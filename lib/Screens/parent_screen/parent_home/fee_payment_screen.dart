import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:json_string/json_string.dart';

class FeePaymentScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const FeePaymentScreen({
    Key key,
    this.documentSnapshot,
  }) : super(key: key);
  @override
  _FeePaymentScreenState createState() => _FeePaymentScreenState();
}

class _FeePaymentScreenState extends State<FeePaymentScreen> {
  Razorpay _razorpay;
  JsonString responseJson;
  String _fee;
  String _selectedSemester;
  int _amount;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_6V7AF1ytCpL2VE',
      'amount': _amount * 100 ?? 'Error Loading, try again',
      'name': '${widget.documentSnapshot.data()['College']}',
      'description': 'Semester Fee',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  Future _getFee(String semester) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      return await firebaseFirestore
          .collection('college')
          .doc('${widget.documentSnapshot.data()['University']}')
          .collection('CollegeNames')
          .doc('${widget.documentSnapshot.data()['College']}')
          .collection('DepartmentNames')
          .doc('${widget.documentSnapshot.data()['Department']}')
          .collection('CourseNames')
          .doc('${widget.documentSnapshot.data()['Course']}')
          .collection('Semester')
          .doc(semester)
          .get()
          .then((docs) {
        setState(() {
          _fee = docs.data()['Fee'] ?? null;
          _amount = int.parse(_fee)??null;
        });
      });
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // _getFee(widget.documentSnapshot.data()['Semester']);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black54, //change your color here
        ),
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.topLeft,
          text: 'Fee Payment',
          size: 18.0,
          color: Colors.black54,
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                width: size.width * 0.8,
                height: size.height * 0.4,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HeadingText(
                      alignment: Alignment.centerLeft,
                      text: 'You are paying for :',
                      size: 20.0,
                      color: Colors.black54,
                    ),
                    HeadingText(
                      alignment: Alignment.centerLeft,
                      text: '${widget.documentSnapshot.data()['Ward_Name']}',
                      size: 15.0,
                      color: Colors.black54,
                    ),
                    HeadingText(
                      alignment: Alignment.centerLeft,
                      text: '${widget.documentSnapshot.data()['Course']}',
                      size: 15.0,
                      color: Colors.black54,
                    ),
                   
                    DropDownListForYearData(
                      universityName:
                          widget.documentSnapshot.data()['University'],
                      collegeName: widget.documentSnapshot.data()['College'],
                      departmentName:
                          widget.documentSnapshot.data()['Department'],
                      courseName: widget.documentSnapshot.data()['Course'],
                      selectedYear: _selectedSemester,
                      onpressed: (val) {
                        setState(() {
                          _selectedSemester = val;
                          _fee = 'select semester';
                        });
                        _getFee(_selectedSemester);
                      },
                    ),
                    HeadingText(
                      alignment: Alignment.center,
                      text:_fee!=null?'Fee = ₹ '+_fee+'/-':'',
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            _fee != null
                ? FloatingActionButton.extended(
                    backgroundColor: HexColor(appSecondaryColour),
                    tooltip: 'Proceed to checkout',
                    onPressed: () {
                      openCheckout();
                    },
                    label: HeadingText(
                      // alignment: Alignment.centerLeft,
                      text: 'Checkout',
                      size: 15.0,
                      color: Colors.white,
                    ),
                    // icon: Icon(Icons.arrow_forward_rounded),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
