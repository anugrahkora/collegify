import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateAnnouncementStudent extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  CreateAnnouncementStudent({Key key, this.documentSnapshot}) : super(key: key);

  @override
  _CreateAnnouncementStudentState createState() =>
      _CreateAnnouncementStudentState();
}

class _CreateAnnouncementStudentState extends State<CreateAnnouncementStudent> {
  String _subject;

  String _announcement;

  bool _loading = false;

  final _formkey = GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor(appPrimaryColour),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
          child: ImageIcon(
            AssetImage('assets/icons/iconStudent.png'),
            color: HexColor(appSecondaryColour),
          ),
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  width: size.width * 0.8,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? '* Mandatory' : null,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            onChanged: (val) {
                              setState(() {
                                _subject = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.montserrat(
                                  color: Colors.black54, fontSize: 16),
                              hintText: 'Subject',
                              border: InputBorder.none,
                            ),
                          ),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? '* Mandatory' : null,
                            keyboardType: TextInputType.multiline,
                            maxLines: 30,
                            onChanged: (val) {
                              setState(() {
                                _announcement = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.montserrat(
                                  color: Colors.black54, fontSize: 16),
                              hintText: 'Announcement',
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                RoundedButton(
                  text: _loading?'....':'Post',
                  color: HexColor(appPrimaryColourDark),
                  loading: false,
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      try{
                      setState(() {
                        _loading = true;
                      });
                      await _post(
                        {'Subject': _subject, 'Announcement': _announcement},
                      );
                      setState(() {
                        _loading = false;
                      });
                      }catch(e){

                      }
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

  _post(Map<String, String> announcement) async {
    try {
      final DocumentReference addStudentAnnouncement = FirebaseFirestore
          .instance
          .collection('college')
          .doc('${widget.documentSnapshot.data()['University']}')
          .collection('CollegeNames')
          .doc('${widget.documentSnapshot.data()['College']}')
          .collection('DepartmentNames')
          .doc('${widget.documentSnapshot.data()['Department']}')
          .collection('CourseNames')
          .doc('${widget.documentSnapshot.data()['Course']}')
          .collection('Semester')
          .doc('${widget.documentSnapshot.data()['Semester']}');
      return await addStudentAnnouncement.update({
        'Student_Announcements': FieldValue.arrayUnion([announcement]),
      });
    } catch (e) {
      rethrow;
    }
  }
}
