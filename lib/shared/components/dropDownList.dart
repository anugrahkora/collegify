import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// dropdown list for listing the all the available universities

class DropDownListForUniversityNames extends StatefulWidget {
  final Function onpressed;

  final String selectedUniversity;
  DropDownListForUniversityNames({
    this.onpressed,
    this.selectedUniversity,
  });
  @override
  _DropDownListForUniversityNamesState createState() =>
      _DropDownListForUniversityNamesState();
}

class _DropDownListForUniversityNamesState
    extends State<DropDownListForUniversityNames> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        
        border: Border.all(color: Colors.black54,width: 1.0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
       
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('college').snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> university = [];

          if (!snapshot.hasData) {
            return  Loader(
                
                size:20.0,
                spinnerColor: Colors.black54,
              
            );
          }

          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
            university.add(
              DropdownMenuItem(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    documentSnapshot.id.replaceAll('_', ' '),
                    style: GoogleFonts.montserrat(
                        color: Colors.black54, fontSize: 14),
                  ),
                ),
                value: "${documentSnapshot.id}",
              ),
            );
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton(
              elevation: 16,
              hint: Text(
                "Select university",
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
              ),
              value: widget.selectedUniversity,
              items: university,
              onChanged: widget.onpressed,
            ),
          );
        },
      ),
    );
  }
}

// dropdown list for listing all colleges under a selected university

class DropdownListForCollegeName extends StatefulWidget {
  final String universityName;
  final Function onpressed;
  final String selectedCollegeName;
  DropdownListForCollegeName({
    this.onpressed,
    this.selectedCollegeName,
    this.universityName,
  });
  @override
  _DropdownListForCollegeNameState createState() =>
      _DropdownListForCollegeNameState();
}

class _DropdownListForCollegeNameState
    extends State<DropdownListForCollegeName> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      height: 58,
      decoration: BoxDecoration(
        
        border: Border.all(color: Colors.black54,width: 1.0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('college')
            .doc("${widget.universityName}")
            .collection('CollegeNames')
            .snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> collegeName = [];

          if (!snapshot.hasData) {
            return  Loader(
                
                size:20.0,
                spinnerColor: Colors.black54,
              
            );
          }
            for (int i = 0; i < snapshot.data.docs.length; i++) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
              collegeName.add(
                DropdownMenuItem(
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        documentSnapshot.id.replaceAll('_', ' '),
                        style: GoogleFonts.montserrat(
                            color: Colors.black54, fontSize: 14),
                      ),
                    ),
                  ),
                  value: "${documentSnapshot.id}",
                ),
              );
           
          }

          return 
         
          DropdownButtonHideUnderline(
            child: DropdownButton(
              elevation: 16,
              hint: Text(
                "Select College",
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
              ),
              value: widget.selectedCollegeName,
              items: collegeName,
              onChanged: widget.onpressed,
            ),
          );
        },
      ),
    );
  }
}

//dropdown list for listing all departments under selected college

class DropDownListForDepartmentName extends StatefulWidget {
  final String universityName;
  final String collegeName;
  final String selectedDepartmentName;
  final Function onpressed;

  DropDownListForDepartmentName(
      {this.collegeName,
      this.onpressed,
      this.selectedDepartmentName,
      this.universityName});
  @override
  _DropDownListForDepartmentNameState createState() =>
      _DropDownListForDepartmentNameState();
}

class _DropDownListForDepartmentNameState
    extends State<DropDownListForDepartmentName> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      height: 58.0,
      decoration: BoxDecoration(
        
     border: Border.all(color: Colors.black54,width: 1.0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
       
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('college')
            .doc("${widget.universityName}")
            .collection('CollegeNames')
            .doc("${widget.collegeName}")
            .collection('DepartmentNames')
            .snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> departmentName = [];

          if (!snapshot.hasData) {
            return Loader(
                
                size:20.0,
                spinnerColor: Colors.black54,
              
            );
          }

          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
            departmentName.add(
              DropdownMenuItem(
                child: SizedBox(
                  width: size.width * 0.6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      documentSnapshot.id.replaceAll('_', ' '),
                      style: GoogleFonts.montserrat(
                          color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ),
                value: "${documentSnapshot.id}",
              ),
            );
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton(
              elevation: 16,
              hint: Text(
                "Select your department",
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
              ),
              value: widget.selectedDepartmentName,
              items: departmentName,
              onChanged: widget.onpressed,
            ),
          );
        },
      ),
    );
  }
}

//dropdown list for courses under selected department

class DropDownListForCourseNames extends StatefulWidget {
  final String universityName;
  final String collegeName;
  final String departmentName;
  final String selectedCourseName;
  final Function onpressed;

  const DropDownListForCourseNames({
    Key key,
    this.universityName,
    this.collegeName,
    this.selectedCourseName,
    this.onpressed,
    this.departmentName,
  }) : super(key: key);
  @override
  _DropDownListForCourseNamesState createState() =>
      _DropDownListForCourseNamesState();
}

class _DropDownListForCourseNamesState
    extends State<DropDownListForCourseNames> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      height: 58.0,
      decoration: BoxDecoration(
        
         border: Border.all(color: Colors.black54,width: 1.0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
       
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('college')
            .doc("${widget.universityName}")
            .collection('CollegeNames')
            .doc("${widget.collegeName}")
            .collection('DepartmentNames')
            .doc('${widget.departmentName}')
            .collection('CourseNames')
            .snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> courseName = [];

          if (!snapshot.hasData) {
            return
                Loader(
                
                size:20.0,
                spinnerColor: Colors.black54,
              
            );
            
          }

          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
            courseName.add(
              DropdownMenuItem(
                child: SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      documentSnapshot.id.replaceAll('_', ' '),
                      style: GoogleFonts.montserrat(
                          color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ),
                value: "${documentSnapshot.id}",
              ),
            );
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton(
              elevation: 16,
              hint: Text(
                "Select your course",
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
              ),
              value: widget.selectedCourseName,
              items: courseName,
              onChanged: widget.onpressed,
            ),
          );
        },
      ),
    );
  }
}

//this list takes in a list as arguments
class DropDownList extends StatefulWidget {
  final List<String> list;
  final String selectedItem;
  final Function onpressed;

  const DropDownList({Key key, this.list, this.selectedItem, this.onpressed})
      : super(key: key);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          elevation: 16,
          hint: Text("Select year"),
          value: widget.selectedItem,
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: widget.onpressed,
        ),
      ),
    );
  }
}

//List of years
class DropDownListForYearData extends StatefulWidget {
  final String universityName;
  final String collegeName;
  final String departmentName;
  final String courseName;
  final String selectedYear;
  final Function onpressed;

  const DropDownListForYearData(
      {Key key,
      this.universityName,
      this.collegeName,
      this.departmentName,
      this.onpressed,
      this.courseName,
      this.selectedYear})
      : super(key: key);
  @override
  _DropDownListForYearDataState createState() =>
      _DropDownListForYearDataState();
}

class _DropDownListForYearDataState extends State<DropDownListForYearData> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      height: 58,
      decoration: BoxDecoration(
        
        border: Border.all(color: Colors.black54,width: 1.0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
       
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('college')
            .doc("${widget.universityName}")
            .collection('CollegeNames')
            .doc("${widget.collegeName}")
            .collection('DepartmentNames')
            .doc("${widget.departmentName}")
            .collection('CourseNames')
            .doc("${widget.courseName}")
            .collection('Semester')
            .snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> yearData = [];

          if (!snapshot.hasData) {
            return  Loader(
                
                size:20.0,
                spinnerColor: Colors.black54,
              
            );
          }

          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
            yearData.add(
              DropdownMenuItem(
                child: SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    documentSnapshot.id,
                    style: GoogleFonts.montserrat(color: Colors.black54),
                  ),
                ),
                value: "${documentSnapshot.id}",
              ),
            );
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton(
              elevation: 16,
              hint: Text(
                "Select Semester",
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
              ),
              value: widget.selectedYear,
              items: yearData,
              onChanged: widget.onpressed,
            ),
          );
        },
      ),
    );
  }
}

class ImageListView extends StatefulWidget {
  @override
  _ImageListViewState createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
