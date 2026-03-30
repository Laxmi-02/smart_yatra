import 'package:flutter/material.dart';
import 'payment_processing_screen.dart';

class NetbankingPaymentScreen extends StatefulWidget {
  final Map<String, dynamic> bus;
  final List<int> selectedSeats;
  final int totalPrice;
  final String passengerName;
  final String passengerPhone;

  const NetbankingPaymentScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
    required this.passengerName,
    required this.passengerPhone,
  });

  @override
  State<NetbankingPaymentScreen> createState() =>
      _NetbankingPaymentScreenState();
}

class _NetbankingPaymentScreenState extends State<NetbankingPaymentScreen> {
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedBank;
  bool _isLoading = false;

  final List<String> _banks = [
    'SBI',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'PNB',
    'BOB',
    'Canara Bank',
    'Union Bank',
  ];

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _payNow() {
    if (_selectedBank == null ||
        _userIdController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select bank and fill login details'),
        ),
      );
      return;
    }

    // Show confirmation
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Login to $_selectedBank?'),
        content: const Text(
          'You will be redirected to bank secure login page.',
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
            child: const Text('Proceed'),
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
          paymentMethod: 'netbanking',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Net Banking'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.greenAccent],
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

            Icon(Icons.account_balance, size: 80, color: Colors.green.shade700),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _selectedBank,
              hint: const Text('Select Your Bank'),
              items: _banks
                  .map(
                    (bank) => DropdownMenuItem(value: bank, child: Text(bank)),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _selectedBank = val),
              decoration: InputDecoration(
                labelText: 'Bank Name',
                prefixIcon: const Icon(
                  Icons.account_balance,
                  color: Colors.green,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.green.shade50,
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: 'User ID / Account Number',
                prefixIcon: const Icon(Icons.person, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.green.shade50,
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.green.shade50,
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _payNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.green.shade700),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bank Grade Security',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          '256-bit SSL Encrypted',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
