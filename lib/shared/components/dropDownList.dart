import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/loadingWidget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// dropdown list for listing the all the available universities

class DropDownListForInstitutionData extends StatefulWidget {
  final String institution;
  final Function onpressed;
  final String selectedInstitution;
  DropDownListForInstitutionData(
      {this.institution, this.onpressed, this.selectedInstitution});
  @override
  _DropDownListForInstitutionDataState createState() =>
      _DropDownListForInstitutionDataState();
}

class _DropDownListForInstitutionDataState
    extends State<DropDownListForInstitutionData> {
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
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("${widget.institution}")
            .snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> institution = [];

          if (!snapshot.hasData) {
            return Text('Loading');
          }
          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
            institution.add(
              DropdownMenuItem(
                child: Text(
                  documentSnapshot.id.replaceAll('_', ' '),
                  style: GoogleFonts.montserrat(color: Colors.black54),
                ),
                value: "${documentSnapshot.id}",
              ),
            );
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text("Select university"),
              value: widget.selectedInstitution,
              items: institution,
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
  final String institution;
  final String universityName;
  final Function onpressed;
  final String selectedCollegeName;
  DropdownListForCollegeName(
      {this.onpressed,
      this.selectedCollegeName,
      this.universityName,
      this.institution});
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("${widget.institution}")
            .doc("${widget.universityName}")
            .collection('CollegeNames')
            .snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> collegeName = [];

          if (!snapshot.hasData) {
            return SizedBox(
              width: size.width * 0.5,
              child: Text(
                'Please select a University',
                style: GoogleFonts.montserrat(color: Colors.black54),
              ),
            );
          }

          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
            collegeName.add(
              DropdownMenuItem(
                child: SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    documentSnapshot.id.replaceAll('_', ' '),
                    style: GoogleFonts.montserrat(color: Colors.black54),
                  ),
                ),
                value: "${documentSnapshot.id}",
              ),
            );
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text("Select College"),
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
  final String institution;
  final String universityName;
  final String collegeName;
  final String selectedDepartmentName;
  final Function onpressed;

  DropDownListForDepartmentName(
      {this.collegeName,
      this.institution,
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("${widget.institution}")
            .doc("${widget.universityName}")
            .collection('CollegeNames')
            .doc("${widget.collegeName}")
            .collection('DepartmentNames')
            .snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> departmentName = [];

          if (!snapshot.hasData) {
            return SizedBox(
              width: size.width * 0.5,
              child: Text(
                'Please select a University & College',
                style: GoogleFonts.montserrat(color: Colors.black54),
              ),
            );
          }

          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
            departmentName.add(
              DropdownMenuItem(
                child: SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    documentSnapshot.id.replaceAll('_', ' '),
                    style: GoogleFonts.montserrat(color: Colors.black54),
                  ),
                ),
                value: "${documentSnapshot.id}",
              ),
            );
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text("Select your department"),
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
