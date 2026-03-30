import 'package:flutter/material.dart';
import 'payment_processing_screen.dart';

class WalletPaymentScreen extends StatefulWidget {
  final Map<String, dynamic> bus;
  final List<int> selectedSeats;
  final int totalPrice;
  final String passengerName;
  final String passengerPhone;

  const WalletPaymentScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
    required this.passengerName,
    required this.passengerPhone,
  });

  @override
  State<WalletPaymentScreen> createState() => _WalletPaymentScreenState();
}

class _WalletPaymentScreenState extends State<WalletPaymentScreen> {
  String? _selectedWallet;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _wallets = [
    {'name': 'Google Pay', 'color': Colors.green, 'icon': Icons.g_mobiledata},
    {'name': 'PhonePe', 'color': Colors.purple, 'icon': Icons.phone_android},
    {'name': 'Paytm', 'color': Colors.blue, 'icon': Icons.wallet},
    {'name': 'Amazon Pay', 'color': Colors.orange, 'icon': Icons.shopping_cart},
    {'name': 'MobiKwik', 'color': Colors.blue, 'icon': Icons.credit_card},
  ];

  void _payNow() {
    if (_selectedWallet == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a wallet')));
      return;
    }

    // Show confirmation
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Open $_selectedWallet?'),
        content: const Text('You will be redirected to wallet app.'),
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
            child: const Text('Open App'),
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
          paymentMethod: 'wallet',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wallet Payment'),
        backgroundColor: Colors.orange,
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
                  colors: [Colors.orange, Colors.orangeAccent],
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

            Icon(
              Icons.account_balance_wallet,
              size: 80,
              color: Colors.orange.shade700,
            ),
            const SizedBox(height: 20),

            const Text(
              'Select Wallet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            ..._wallets.map(
              (wallet) => GestureDetector(
                onTap: () => setState(() => _selectedWallet = wallet['name']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _selectedWallet == wallet['name']
                        ? (wallet['color'] as Color).withOpacity(0.1)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _selectedWallet == wallet['name']
                          ? wallet['color'] as Color
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        wallet['icon'] as IconData,
                        color: _selectedWallet == wallet['name']
                            ? wallet['color'] as Color
                            : Colors.grey,
                        size: 30,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        wallet['name'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: _selectedWallet == wallet['name']
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: _selectedWallet == wallet['name']
                              ? wallet['color'] as Color
                              : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: wallet['name'],
                        groupValue: _selectedWallet,
                        onChanged: (v) => setState(() => _selectedWallet = v),
                        activeColor: wallet['color'] as Color,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _payNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
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
                          'Secure Wallet Payment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Redirects to official wallet app',
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
