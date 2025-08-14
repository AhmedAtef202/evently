import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/firebase/firebasemanger.dart';
import 'package:evently_app/models/createevent.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavTab extends StatelessWidget {
  const FavTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<TaskModel>>(
        stream: Firebasemanger.getTasks(isFav: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text("something went wrong"));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Events"));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  var date = DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!.docs[index].data().date);
                  String month = DateFormat("MMM").format(date);
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/${snapshot.data!.docs[index].data().category}.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      date.toString().substring(8, 10),
                                      style: GoogleFonts.inter(
                                          color: AppColor.primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      month.substring(0, 3),
                                      style: GoogleFonts.inter(
                                          color: AppColor.primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                title: Text(
                                    snapshot.data!.docs[index].data().title,
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Firebasemanger.addTaskFav(
                                        snapshot.data!.docs[index].id,
                                        !snapshot.data!.docs[index]
                                            .data()
                                            .isFav);
                                  },
                                  child: Icon(
                                      snapshot.data!.docs[index].data().isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: AppColor.primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                itemCount: snapshot.data!.docs.length),
          );
        });
  }
}
