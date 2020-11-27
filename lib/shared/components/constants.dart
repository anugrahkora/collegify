import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

const appPrimaryColour = '#55D9C1';
const appSecondaryColour = '#0D0D0D';
const studentPrimaryColour = '#A9CBD9';
const teacherPrimaryColour = '#73A2BF';
const parentPrimaryColour = '#537FA6';
const welcomePrimaryColour = '#F2F2F2';

class HeadingText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const HeadingText({
    Key key,
    this.color,
    this.text,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: size,
            color: color,
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatefulWidget {
  final String text, route;
  final Function press;
  final Color color, textColor;

  RoundedButton({
    this.text,
    this.route,
    this.press,
    this.color,
    this.textColor,
  }) : super();

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: widget.color,
          onPressed: widget.press,
          child: Text(
            widget.text,
            style:
                GoogleFonts.montserrat(color: widget.textColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Color color;
  final bool boolean;
  final Function validator;

  RoundedInputField({
    Key key,
    this.hintText,
    this.onChanged,
    this.color,
    this.boolean = false,
    this.validator,
  }) : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: widget.validator,
        onSaved: widget.onChanged,
        obscureText: widget.boolean,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatefulWidget {
  final Widget child;
  final Color color;

  const TextFieldContainer({
    Key key,
    this.child,
    this.color: Colors.white,
  }) : super(key: key);

  @override
  _TextFieldContainerState createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: widget.child,
    );
  }
}

class AlertWidget extends StatelessWidget {
  final String message;

  final Function onpressed;
  AlertWidget({this.message, this.onpressed});
  @override
  Widget build(BuildContext context) {
    if (message != null) {
      return Container(
        color: Colors.amber,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline_rounded),
            ),
            Expanded(
              child: AutoSizeText(
                message,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: onpressed,
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

class DropDownListContainer extends StatefulWidget {
  //final Widget child;
  final Color color;
  final int data;
  final ValueChanged<int> onpressed;
  DropDownListContainer({
    this.color,
    this.onpressed,
    this.data,
  });

  @override
  _DropDownListContainerState createState() => _DropDownListContainerState();
}

class _DropDownListContainerState extends State<DropDownListContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: widget.data,
          items: [
            DropdownMenuItem(
              child: Text('1st year',
                  style: GoogleFonts.montserrat(color: Colors.black54)),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text('2nd year',
                  style: GoogleFonts.montserrat(color: Colors.black54)),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text('3rd year',
                  style: GoogleFonts.montserrat(color: Colors.black54)),
              value: 3,
            ),
          ],
          onChanged: widget.onpressed,
        ),
      ),
    );
  }
}
