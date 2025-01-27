import 'package:d2/other/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late Razorpay _razorpay;
  final TextEditingController amountController = TextEditingController();

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
    _razorpay.clear();
    super.dispose();
  }

  void _openCheckout(int amount) {
    var options = {
      'key': 'your_actual_razorpay_key_here', // Replace with actual Razorpay key
      'amount': amount * 100, // Razorpay expects amount in paise
      'name': 'Doctor App',
      'description': 'Payment for services',
      'prefill': {
        'contact': '1234567890', // Replace with actual contact
        'email': 'user@example.com', // Replace with actual email
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      Fluttertoast.showToast(
        msg: "Error in payment: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Successful: ${response.paymentId}",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed: ${response.message}",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "External Wallet Selected: ${response.walletName}",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.text),
        title: const Text('Payment Page',style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 270,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/The easy Care Logo-Photoroom.png',
                      fit: BoxFit.contain,
                      height: 250,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to Payment',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                cursorColor: AppColors.primary,
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (amountController.text.isNotEmpty) {
                  try {
                    int amount = int.parse(amountController.text);
                    if (amount > 0) {
                      _openCheckout(amount);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Amount must be greater than zero",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Invalid amount entered",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: "Please enter an amount",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text(
                'Pay',
                style: TextStyle(color: AppColors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
