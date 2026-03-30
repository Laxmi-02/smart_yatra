import 'package:flutter/material.dart';
import 'payment_processing_screen.dart';

class UpiPaymentScreen extends StatefulWidget {
  final Map<String, dynamic> bus;
  final List<int> selectedSeats;
  final int totalPrice;
  final String passengerName;
  final String passengerPhone;

  const UpiPaymentScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
    required this.passengerName,
    required this.passengerPhone,
  });

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  final _upiIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _upiIdController.dispose();
    super.dispose();
  }

  void _payNow() {
    if (_upiIdController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter UPI ID')));
      return;
    }

    // Show UPI PIN Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter UPI PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Paying ₹${widget.totalPrice} to SmartYatra'),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 5),
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                counterText: '',
                hintText: '● ● ● ● ● ●',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _proceedToProcessing();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Verify & Pay'),
          ),
        ],
      ),
    );
  }

  void _proceedToProcessing() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentProcessingScreen(
          bus: widget.bus,
          selectedSeats: widget.selectedSeats,
          totalPrice: widget.totalPrice,
          passengerName: widget.passengerName,
          passengerPhone: widget.passengerPhone,
          paymentMethod: 'upi',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('UPI Payment'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Amount Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.purpleAccent],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text(
                    'Amount to Pay',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '₹${widget.totalPrice}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // UPI Icon
            Icon(Icons.qr_code_2, size: 100, color: Colors.purple.shade700),
            const SizedBox(height: 20),

            // UPI ID Input
            TextField(
              controller: _upiIdController,
              decoration: InputDecoration(
                labelText: 'Enter UPI ID',
                hintText: 'example@oksbi',
                prefixIcon: const Icon(Icons.person, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.purple.shade50,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Example: mobile@okhdfc, name@paytm',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Pay Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _payNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Security Info            Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green.shade200)), child: Row(children: [Icon(Icons.security, color: Colors.green.shade700), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('100% Secure Payment', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)), Text('Your UPI PIN is never stored', style: TextStyle(fontSize: 12, color: Colors.green.shade700))]))])),
          ],
        ),
      ),
    );
  }
}
