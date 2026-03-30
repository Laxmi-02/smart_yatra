import 'package:flutter/material.dart';
import 'upi_payment_screen.dart';
import 'card_payment_screen.dart';
import 'netbanking_payment_screen.dart';
import 'wallet_payment_screen.dart';
import 'payment_processing_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> bus;
  final List<int> selectedSeats;
  final int totalPrice;
  final String passengerName;
  final String passengerPhone;

  const PaymentScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
    required this.passengerName,
    required this.passengerPhone,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'upi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Amount Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Total Amount to Pay',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  '₹${widget.totalPrice}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  _buildOption(
                    'upi',
                    'UPI Payment',
                    Icons.qr_code_2,
                    Colors.purple,
                    'Pay via UPI ID',
                  ),
                  _buildOption(
                    'card',
                    'Credit/Debit Card',
                    Icons.credit_card,
                    Colors.blue,
                    'Enter Card Details',
                  ),
                  _buildOption(
                    'netbanking',
                    'Net Banking',
                    Icons.account_balance,
                    Colors.green,
                    'Bank Login Required',
                  ),
                  _buildOption(
                    'wallet',
                    'Wallets',
                    Icons.account_balance_wallet,
                    Colors.orange,
                    'GPay/PhonePe/Paytm',
                  ),
                  _buildOption(
                    'cod',
                    'Cash on Board',
                    Icons.money,
                    Colors.teal,
                    'Pay in Bus',
                  ),

                  const SizedBox(height: 20),

                  // Booking Summary
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _row('Bus', widget.bus['name']),
                        _row('Seats', widget.selectedSeats.join(', ')),
                        _row('Passenger', widget.passengerName),
                        _row('Contact', widget.passengerPhone),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Continue Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    String value,
    String title,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    bool isSelected = _selectedMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 35),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? color : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Radio(
              value: value,
              groupValue: _selectedMethod,
              onChanged: (v) => setState(() => _selectedMethod = v!),
              activeColor: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _proceedToPayment() {
    switch (_selectedMethod) {
      case 'upi':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpiPaymentScreen(
              bus: widget.bus,
              selectedSeats: widget.selectedSeats,
              totalPrice: widget.totalPrice,
              passengerName: widget.passengerName,
              passengerPhone: widget.passengerPhone,
            ),
          ),
        );
        break;
      case 'card':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardPaymentScreen(
              bus: widget.bus,
              selectedSeats: widget.selectedSeats,
              totalPrice: widget.totalPrice,
              passengerName: widget.passengerName,
              passengerPhone: widget.passengerPhone,
            ),
          ),
        );
        break;
      case 'netbanking':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NetbankingPaymentScreen(
              bus: widget.bus,
              selectedSeats: widget.selectedSeats,
              totalPrice: widget.totalPrice,
              passengerName: widget.passengerName,
              passengerPhone: widget.passengerPhone,
            ),
          ),
        );
        break;
      case 'wallet':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletPaymentScreen(
              bus: widget.bus,
              selectedSeats: widget.selectedSeats,
              totalPrice: widget.totalPrice,
              passengerName: widget.passengerName,
              passengerPhone: widget.passengerPhone,
            ),
          ),
        );
        break;
      case 'cod':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentProcessingScreen(
              bus: widget.bus,
              selectedSeats: widget.selectedSeats,
              totalPrice: widget.totalPrice,
              passengerName: widget.passengerName,
              passengerPhone: widget.passengerPhone,
              paymentMethod: 'cod',
            ),
          ),
        );
        break;
    }
  }
}
