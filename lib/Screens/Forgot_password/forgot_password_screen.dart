import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        centerTitle: true,
        backgroundColor:Colors.white,
        title:HeadingText(alignment: Alignment.topLeft,
          color: Colors.black54,
          text:'Change your password',
          size: 15.0,

        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
       
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),

                RoundedInputField(
                  hintText: 'Enter your secret key',
                  color: Colors.white,
                  onChanged: (val){

                  },
                   validator: (val) =>
                        val.isEmpty ? 'Oops! you left this field empty' : null,
                ),
              ],),
            ),
         
        ),
      ),
    );
  }
}
