import 'package:auto_size_text/auto_size_text.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

const appPrimaryColour = '#F0F1F2';
const appSecondaryColour = '#225c73';
const appPrimaryColourDark = '#99b4bf';
const appPrimaryColourLight = '#ffffff';

class HeadingText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final Alignment alignment;
  const HeadingText(
      {Key key,
      this.color,
      this.text,
      this.size,
      this.alignment: Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: size,
          color: color,
        ),
      ),
    );
  }
}

class RoundedField extends StatefulWidget {
  final String label;
  final String text;
  final Color color;

  const RoundedField({Key key, this.text, this.color, this.label})
      : super(key: key);
  @override
  _RoundedFieldState createState() => _RoundedFieldState();
}

class _RoundedFieldState extends State<RoundedField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: HexColor(appSecondaryColour),
          width: 1.5,
        ),
        color: HexColor(appPrimaryColour),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(29.0)),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              HeadingText(
                alignment: Alignment.topLeft,
                text: widget.text,
                color: widget.color,
                size: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final bool loading;
  final Color textColor;

  RoundedButton({
    this.text,
    this.color,
    this.loading,
    this.onPressed,
    this.textColor: Colors.white,
  }) : super();

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: widget.color,
          onPressed: widget.onPressed,
          child: widget.loading
              ? Loader(
                  color: HexColor(appSecondaryColour),
                  size: 20,
                )
              : Text(
                  widget.text,
                  style: GoogleFonts.montserrat(
                      color: widget.textColor, fontSize: 16),
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
  //final List<TextInputFormatter> textInputFormatter;

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
        //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: widget.validator,
        onChanged: widget.onChanged,
        obscureText: widget.boolean,
        decoration: InputDecoration(
          hintStyle:
              GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
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
        border: Border.all(color: Colors.black54,width: 1.0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: widget.child,
    );
  }
}

class RoundedInputFieldNumbers extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Color color;
  final bool boolean;
  final Function validator;
  //final List<TextInputFormatter> textInputFormatter;

  RoundedInputFieldNumbers({
    Key key,
    this.hintText,
    this.onChanged,
    this.color,
    this.boolean = false,
    this.validator,
  }) : super(key: key);

  @override
  _RoundedInputFieldNumbersState createState() =>
      _RoundedInputFieldNumbersState();
}

class _RoundedInputFieldNumbersState extends State<RoundedInputFieldNumbers> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: widget.validator,
        onChanged: widget.onChanged,
        obscureText: widget.boolean,
        decoration: InputDecoration(
          hintStyle:
              GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextFieldContainerNumbers extends StatefulWidget {
  final Widget child;
  final Color color;

  const TextFieldContainerNumbers({
    Key key,
    this.child,
    this.color: Colors.white,
  }) : super(key: key);

  @override
  _TextFieldContainerNumbersState createState() =>
      _TextFieldContainerNumbersState();
}

class _TextFieldContainerNumbersState extends State<TextFieldContainerNumbers> {
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
      child: widget.child,
    );
  }
}

class AlertWidget extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;

  final Function onpressed;
  AlertWidget(
      {this.message,
      this.onpressed,
      this.color,
      this.icon: Icons.error_outline_rounded});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (message != null) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: color,
        ),

        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon),
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

class RoundedInputFieldExtended extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Color color;

  final Function validator;

  const RoundedInputFieldExtended(
      {Key key, this.hintText, this.onChanged, this.color, this.validator})
      : super(key: key);
  @override
  _RoundedInputFieldExtendedState createState() =>
      _RoundedInputFieldExtendedState();
}

class _RoundedInputFieldExtendedState extends State<RoundedInputFieldExtended> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainerExtended(
      child: TextFormField(
        //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: widget.validator,
        onChanged: widget.onChanged,

        decoration: InputDecoration(
          hintStyle:
              GoogleFonts.montserrat(color: Colors.black54, fontSize: 14),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextFieldContainerExtended extends StatefulWidget {
  final Widget child;
  final Color color;

  const TextFieldContainerExtended({
    Key key,
    this.child,
    this.color: Colors.white,
  }) : super(key: key);

  @override
  _TextFieldContainerExtendedState createState() =>
      _TextFieldContainerExtendedState();
}

class _TextFieldContainerExtendedState
    extends State<TextFieldContainerExtended> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      height: size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: widget.child,
    );
  }
}
