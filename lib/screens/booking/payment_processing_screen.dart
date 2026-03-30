import 'package:flutter/material.dart';
import '../ticket/ticket_screen.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final Map<String, dynamic> bus;
  final List<int> selectedSeats;
  final int totalPrice;
  final String passengerName;
  final String passengerPhone;
  final String paymentMethod;

  const PaymentProcessingScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
    required this.passengerName,
    required this.passengerPhone,
    required this.paymentMethod,
  });

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _startProcessing();
  }

  Future<void> _startProcessing() async {
    // 3 seconds wait (Payment processing simulation)
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      // Generate Booking ID
      String bookingId =
          'SY${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

      // Navigate to Ticket Screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => TicketScreen(
            bus: widget.bus,
            selectedSeats: widget.selectedSeats,
            totalPrice: widget.totalPrice,
            passengerName: widget.passengerName,
            passengerPhone: widget.passengerPhone,
            paymentMethod: widget.paymentMethod,
            bookingId: bookingId,
          ),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loading Circle with Icon
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        strokeWidth: 4,
                      ),
                      Icon(
                        Icons.check_circle_outline,
                        size: 50,
                        color: Colors.green.shade700,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Processing Text
                const Text(
                  'Processing Payment...',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  'Please do not close this window',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Amount Box
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Paying via ${_getPaymentMethodName()}',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '₹${widget.totalPrice}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Security Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.green.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '100% Secure Payment',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Animated Dots
                AnimatedDots(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPaymentMethodName() {
    switch (widget.paymentMethod) {
      case 'upi':
        return 'UPI';
      case 'card':
        return 'Card';
      case 'netbanking':
        return 'Net Banking';
      case 'wallet':
        return 'Wallet';
      case 'cod':
        return 'Cash on Board';
      default:
        return widget.paymentMethod;
    }
  }
}

// Animated Dots Widget
class AnimatedDots extends StatefulWidget {
  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(0),
            const SizedBox(width: 5),
            _buildDot(1),
            const SizedBox(width: 5),
            _buildDot(2),
          ],
        );
      },
    );
  }

  Widget _buildDot(int index) {
    final delay = index * 0.2;
    final value = (_controller.value - delay) % 1.0;
    final size = 8 + (value * 8);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.3 + (value * 0.7)),
        shape: BoxShape.circle,
      ),
    );
  }
}
