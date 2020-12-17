import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ParentHome extends StatefulWidget {
  @override
  _ParentHomeState createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  bool _loading = false;
  String _university='';
  String _collegeName='';
  String _departmentName='';

  String _courseName='';

  String _parentName = '';
  String _wardName = '';
  String _registrationNumber = '';
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((docs) {
        if (docs.data().isNotEmpty) {
          if(
            this.mounted
          ){setState(() {
            _parentName = docs.data()['Name'] ?? '----';
            _university = docs.data()['University'] ?? '----';
            _collegeName = docs.data()['College'] ?? '----';
            _departmentName = docs.data()['Department'] ?? '----';
            _courseName = docs.data()['Course'] ?? '----';
            
            _wardName=docs.data()['Ward_Name']?? '----';
            _registrationNumber=docs.data()['Registration_Number']?? '----';
          });
          }
        }
      });
    }
    return Scaffold(
       appBar: AppBar(
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.topLeft,
          text: _parentName,
          color: Colors.black,
        ),
        
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
          child: ImageIcon(
            AssetImage('assets/icons/iconParent.png'),
            color:HexColor(appSecondaryColour),
            
          ),
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    
                    RoundedField(
                      label: 'University',
                      text: _university.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                    RoundedField(
                      label: 'College',
                      text: _collegeName.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                    RoundedField(
                      label: 'Department',
                      text: _departmentName.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                    RoundedField(
                      label: 'Course',
                      text: _courseName.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                     RoundedField(
                      label: 'Name of the ward',
                      text: _wardName.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                    RoundedField(
                      label: 'Registration Number',
                      text: _registrationNumber.replaceAll('_', ' '),
                      color: Colors.black,
                    ),

                    SizedBox(
                      height: 40.0,
                    ),
                   


                    RoundedButton(
                text: 'SignOut',
                color: HexColor(appSecondaryColour),
                loading: _loading,
                onPressed: () async {
                  _loading = true;

                  await _authService.signOut();
                },
              ),
                  ],
                ),
        ),
            ],
      ),
        ),
      ),

    );
  }
}
