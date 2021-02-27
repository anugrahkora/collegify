import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

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
      'amount': 12000,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(child: Text("Fee payment screen")),
              FlatButton(
                onPressed: () {
                  openCheckout();
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
