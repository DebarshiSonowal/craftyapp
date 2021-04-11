import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract class Payment{
  void handlePaymentError(PaymentFailureResponse response);
  void handlePaymentSuccess(PaymentSuccessResponse response);
  void handleExternalWallet(ExternalWalletResponse response);
}