import 'package:collegify/database/databaseService.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:collegify/shared/components/dropDownList.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  //bool flag = false;
  String university, newUniversity;
  String college, newCollege;
  String department, newDepartment;
  String course, newCourse;
  String year, newYear;
  String _message;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                AlertWidget(
                  message: _message,
                  onpressed: () {
                    setState(() {
                      _message = null;
                    });
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
                HeadingText(
                  text: 'Admin Page',
                  size: 40.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.0,
                ),
                HeadingText(
                  text: 'add new data',
                  size: 20.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10.0,
                ),
                //list of universities
                DropDownListForUniversityNames(
                  selectedUniversity: university,
                  onpressed: (val) {
                    setState(() {
                      college = null;
                      department = null;
                      course = null;
                      university = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "Add new University",
                  onChanged: (val) {
                    newUniversity = val.replaceAll(' ', '_');
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedButton(
                  text: 'Add new University',
                  loading: loading,
                  color: HexColor(appSecondaryColour),
                  onPressed: () async {
                    try {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await DatabaseService()
                          .addNewUniversity(newUniversity);
                      if (result == null) {
                        setState(() {
                          _message =
                              "Successfuly added ${newUniversity.replaceAll('_', ' ')} ";
                          loading = false;
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        _message = e.toString();
                        loading = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                // list of colleges
                DropdownListForCollegeName(
                  universityName: university,
                  selectedCollegeName: college,
                  onpressed: (val) {
                    setState(() {
                      department = null;
                      course = null;
                      college = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "Add new College",
                  onChanged: (val) {
                    newCollege = val.replaceAll(' ', '_');
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedButton(
                  text: 'Add new college',
                  loading: loading,
                  color: HexColor(appSecondaryColour),
                  onPressed: () async {
                    try {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await DatabaseService()
                          .addNewCollege(university, newCollege);
                      if (result == null) {
                        setState(() {
                          _message =
                              "Successfuly added ${newCollege.replaceAll('_', ' ')} to ${university.replaceAll('_', ' ')} ";
                          loading = false;
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        _message = e.toString();
                        loading = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                //list of departments
                DropDownListForDepartmentName(
                  universityName: university,
                  collegeName: college,
                  selectedDepartmentName: department,
                  onpressed: (val) {
                    setState(() {
                      course = null;
                      department = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "Add new Department",
                  onChanged: (val) {
                    newDepartment = val.replaceAll(' ', '_');
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                DropDownListForCourseNames(
                  universityName: university,
                  collegeName: college,
                  departmentName: department,
                  selectedCourseName: course,
                  onpressed: (val) {
                    course = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "Add new Course",
                  onChanged: (val) {
                    newCourse = val.replaceAll(' ', '_');
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                RoundedInputField(
                  hintText: "Add new year",
                  onChanged: (val) {
                    newYear = val.replaceAll(' ', '_');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
