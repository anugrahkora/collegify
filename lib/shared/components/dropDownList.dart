import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool loading = true;

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
                  documentSnapshot.id,
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
