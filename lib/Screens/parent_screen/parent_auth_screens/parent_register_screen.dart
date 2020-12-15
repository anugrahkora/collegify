//import 'package:collegify/Screens/parent_screen/parent_login_screen.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ParentRegisterScreen extends StatefulWidget {
  @override
  _ParentRegisterScreenState createState() => _ParentRegisterScreenState();
}

class _ParentRegisterScreenState extends State<ParentRegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;
  String _university;
  String _collegeName;
  String _departmentName;

  String _courseName;
  
  String _parentName = '';
  String _wardName = '';
  String _registrationNumber = '';
  String _email = '';
  String _password = '';
  String _message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                AlertWidget(
                  color: Colors.amber,
                  message: _message,
                  onpressed: () {
                    setState(() {
                      _message = null;
                    });
                  },
                ),
                 SizedBox(
                  height: 15.0,
                ),
               Container(
                  child: Center(child: Text(
                  'Register',
                  style:TextStyle(
                    fontFamily: 'Qibtiyah',
                    fontSize: 100,
                    color: Colors.white

                  ),
                   ),
                ),
                ),
                
               Container(
                  child: Center(child: Text(
                  'as parent',
                  style:TextStyle(
                    fontFamily: 'Qibtiyah',
                    fontSize: 40,
                    color: Colors.black,

                  ),
                   ),
                ),
                ),
                DropDownListForUniversityNames(
                  selectedUniversity: _university,
                  onpressed: (val) {
                    setState(() {
                      _collegeName = null;
                      _departmentName = null;
                      _courseName = null;
                      _university = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                // list of colleges
                DropdownListForCollegeName(
                  universityName: _university,
                  selectedCollegeName: _collegeName,
                  onpressed: (val) {
                    setState(() {
                      _departmentName = null;
                      _courseName = null;
                      _collegeName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                //list of departments
                DropDownListForDepartmentName(
                  universityName: _university,
                  collegeName: _collegeName,
                  selectedDepartmentName: _departmentName,
                  onpressed: (val) {
                    setState(() {
                      _courseName = null;
                      _departmentName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                DropDownListForCourseNames(
                  universityName: _university,
                  collegeName: _collegeName,
                  departmentName: _departmentName,
                  selectedCourseName: _courseName,
                  onpressed: (val) {
                    setState(() {
                      _courseName = val;
                     
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Parent name',
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Name of your ward',
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Registration Number',
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Email',
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Password',
                  boolean: true,
                  onChanged: (val) {},
                ),
                RoundedButton(
                  text: 'Register',
                  color: HexColor(appSecondaryColour),
                  loading: _loading,
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
