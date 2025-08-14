import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/createevent.dart';
import 'package:evently_app/models/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebasemanger {
  static CollectionReference<Userdata> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<Userdata>(
          fromFirestore: (snapshot, _) => Userdata.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<void> createEvent(TaskModel task) async {
    var doc = getTaskCollection().doc();
    task.id = doc.id;
    await doc.set(task);
  }

  static addTaskFav(String id, bool flag) {
    getTaskCollection().doc(id).update({'isFav': flag});
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(
      {String? category, bool? isFav}) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }
    if (isFav == true) {
      return getTaskCollection()
          .where("userId", isEqualTo: currentUser.uid)
          .where('isFav', isEqualTo: isFav)
          .snapshots();
    }
    if (category == 'All' || category == null) {
      return getTaskCollection()
          .where("userId", isEqualTo: currentUser.uid)
          .snapshots();
    }
    Stream<QuerySnapshot<TaskModel>> ref = getTaskCollection()
        .where('category', isEqualTo: category)
        .where("userId", isEqualTo: currentUser.uid)
        .orderBy('date', descending: true)
        .snapshots();
    return ref;
  }

  static Future<void> createAccountUser(Userdata user) {
    var doc = getUsersCollection().doc(user.id);
    return doc.set(user);
  }

  static Future<Userdata?> readUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }

    try {
      var doc = await getUsersCollection().doc(currentUser.uid).get();
      return doc.data();
    } catch (e) {
      return null;
    }
  }

  static Login({
    required String email,
    required String password,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        onSuccess();
      } else {
        onError("User not found ");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      } else {
        onError(e.code);
      }
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // المستخدم ألغى تسجيل الدخول
      throw Exception("Google sign in aborted");
    }

    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final userDoc =
        await getUsersCollection().doc(userCredential.user!.uid).get();

    if (!userDoc.exists) {
      Userdata newUser = Userdata(
        phone: '',
        id: userCredential.user!.uid,
        name: googleUser.displayName ?? '',
        email: googleUser.email,
      );
      await createAccountUser(newUser);
    }

    return userCredential;
  }

  static Future<void> updateEvent(TaskModel task) async {
    if (task.id == null || task.id!.isEmpty) {
      throw Exception("Event ID is required to update");
    }
    await getTaskCollection().doc(task.id).update(task.toJson());
  }

  static SignUp({
    required Userdata user,
    required String password,
    required Function onError,
    required Function onSuccess,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email ?? '',
        password: password,
      );

      if (credential.user != null) {
        user.id = credential.user!.uid;
        await createAccountUser(user);
        onSuccess();
      } else {
        onError("User creation failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      } else {
        onError(e.code);
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
