import 'package:collegify/database/databaseService.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String university = '';
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
                HeadingText(
                  text: 'Admin Page',
                  size: 40.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 25.0,
                ),
                RoundedInputField(
                  hintText: "Add new University",
                  validator: (val) =>
                      val.isEmpty ? 'Oops! you left this field empty' : null,
                  onChanged: (val) {
                    university = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: HexColor(appSecondaryColour),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await DatabaseService()
                              .addNewUniversity(university);
                          if (result != null) {
                            print("added $university");
                            setState(() {
                              loading = false;
                            });
                          } else {
                            setState(() {
                              loading = false;
                            });
                          }
                        }
                      },
                      child: loading
                          ? Loader(
                              color: HexColor(appSecondaryColour),
                              size: 20,
                            )
                          : Text(
                              'Add university',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 20),
                            ),
                    ),
                  ),
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
