import 'package:evently_app/firebase/firebasemanger.dart';
import 'package:evently_app/models/createevent.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = 'AddEventScreen';

  final TaskModel? existingEvent; // لو عايز تعدل حدث تبعته هنا

  AddEventScreen({this.existingEvent, super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedCategoryindex = 0;
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  List<String> categories = [
    "sport",
    "meeting",
    "holiday",
    "exhibition",
    "gaming",
    "workshop",
    "eating",
    "bookclub",
    "birthday",
  ];

  @override
  void initState() {
    super.initState();
    // لو في حدث موجود — نملأ الحقول بقيمته
    if (widget.existingEvent != null) {
      var e = widget.existingEvent!;
      titleController.text = e.title;
      descriptionController.text = e.description;
      selectedDate = DateTime.fromMillisecondsSinceEpoch(e.date);
      selectedCategoryindex = categories.indexOf(e.category);
      if (selectedCategoryindex == -1) selectedCategoryindex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.existingEvent != null;

    return Scaffold(
      backgroundColor: AppColor.lightbackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.lightbackgroundColor,
        title: Text(isEditing ? 'Edit Event' : 'Create Event'),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                        "assets/images/${categories[selectedCategoryindex]}.png")),
                SizedBox(height: 12),
                Container(
                  height: 40,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryindex = index;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedCategoryindex == index
                                  ? AppColor.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            child: Text(categories[index],
                                style: TextStyle(
                                  color: selectedCategoryindex == index
                                      ? Colors.white
                                      : AppColor.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ))),
                      );
                    },
                    itemCount: categories.length,
                  ),
                ),
                SizedBox(height: 12),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Title",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    )),
                TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Event Title",
                        labelStyle: GoogleFonts.inter(
                            color: Color(0xff7B7B7B), fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: AppColor.primaryColor,
                          ),
                        ))),
                SizedBox(height: 12),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Description",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    )),
                TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                        hintText: "Event Description",
                        labelStyle: GoogleFonts.inter(
                            color: Color(0xff7B7B7B), fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: AppColor.primaryColor,
                          ),
                        ))),
                SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Event Date",
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () {
                          SelectedData();
                        },
                        child: Text(
                          selectedDate.toString().substring(0, 10),
                          style: GoogleFonts.inter(
                              color: AppColor.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ]),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (!formkey.currentState!.validate()) return;

                        TaskModel task = TaskModel(
                          id: widget.existingEvent?.id ?? '',
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          title: titleController.text,
                          description: descriptionController.text,
                          category: categories[selectedCategoryindex],
                          date: selectedDate.millisecondsSinceEpoch,
                        );

                        if (isEditing) {
                          Firebasemanger.updateEvent(task).then((value) {
                            Navigator.pop(context);
                          });
                        } else {
                          Firebasemanger.createEvent(task).then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Text(
                        isEditing ? "Update Event" : "Add Event",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SelectedData() async {
    DateTime? chosenDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColor.primaryColor,
                onPrimary: Colors.white,
                onSurface: AppColor.primaryColor,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
