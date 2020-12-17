import 'package:collegify/database/databaseService.dart';
import 'package:collegify/shared/components/constants.dart';

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:collegify/shared/components/dropDownList.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String university;
  String college;
  String department, newDepartment;
  String course, newCourse;
  String year, newYear;
  String _message;
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
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
                  color: Colors.greenAccent,
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
                DropDownListForDepartmentName(
                  universityName: university,
                  collegeName: college,
                  selectedDepartmentName: department,
                  onpressed: (val) {
                    setState(() {
                      course = null;
                      newDepartment = null;
                      newCourse = null;
                      newYear = null;
                      department = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "New Department Name",
                  onChanged: (val) {
                    newDepartment = val.replaceAll(' ', '_');
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedButton(
                  text: 'Add new department',
                  loading: loading,
                  color: HexColor(appSecondaryColour),
                  onPressed: () async {
                    try {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await DatabaseService()
                          .addNewDepartment(university, college, newDepartment);
                      if (result == null) {
                        setState(() {
                          _message =
                              "Successfuly added ${newDepartment.replaceAll('_', ' ')} in ${university.replaceAll('_', ' ')},${college.replaceAll('_', ' ')} ";
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

                // list of courses
                DropDownListForCourseNames(
                  universityName: university,
                  collegeName: college,
                  departmentName: department,
                  selectedCourseName: course,
                  onpressed: (val) {
                    setState(() {
                      course = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "New Course name",
                  onChanged: (val) {
                    newCourse = val.replaceAll(' ', '_');
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedButton(
                  text: 'Add new course',
                  loading: loading,
                  color: HexColor(appSecondaryColour),
                  onPressed: () async {
                    try {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await DatabaseService().addNewCourse(
                          university, college, department, newCourse);
                      if (result == null) {
                        setState(() {
                          _message =
                              "Successfuly added ${newCourse.replaceAll('_', ' ')} in ${university.replaceAll('_', ' ')},${college.replaceAll('_', ' ')}, ${department.replaceAll('_', ' ')}";
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

                DropDownListForYearData(
                  universityName: university,
                  collegeName: college,
                  departmentName: department,
                  courseName: course,
                  selectedYear: year,
                  onpressed: (val) {
                    year = val;
                  },
                ),

                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "Add new year",
                  onChanged: (val) {
                    newYear = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),

                RoundedButton(
                  text: 'Add new year',
                  loading: loading,
                  color: HexColor(appSecondaryColour),
                  onPressed: () async {
                    try {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await DatabaseService().addNewYear(
                          university, college, department, course, newYear);
                      if (result == null) {
                        setState(() {
                          _message =
                              "Successfuly added $newYear to ${university.replaceAll('_', ' ')},${course.replaceAll('_', ' ')}";
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
