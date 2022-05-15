import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class PaymentService extends StatefulWidget {
  static String id = 'payment_screen';
  @override
  _PaymentServiceState createState() => _PaymentServiceState();
}

class _PaymentServiceState extends State<PaymentService> {
  Razorpay _razorpay;
  TextEditingController amount = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void openCheckOut() async {
    var options = {
      'key': 'rzp_test_r4KkBnAa9Z5NZc',
      'amount': num.parse(amount.text) * 100,
      'name': 'Vaibhav',
      'description': 'Thank you for Helping Me',
      'prefill': {
        'contact': '+91 8245644477',
        'email': 'thankyou@gmail.com',
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('payment success');
    Toast.show('payment succes', context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('payment error');
    Toast.show('payment error', context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('external wallet');
    Toast.show('external wallet', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        backgroundColor: Colors.teal.shade100,
        title: Text(
          'Donate Kart',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: amount,
              style: TextStyle(
                fontSize: 25.0,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 250.0,
            ),
            FlatButton(
              height: 50.0,
              color: Colors.teal.shade100,
              onPressed: () {
                openCheckOut();
              },
              child: Text(
                'DONATE NOW',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.teal.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
