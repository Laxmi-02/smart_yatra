import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class TicketScreen extends StatelessWidget {
  final Map<String, dynamic> bus;
  final List<int> selectedSeats;
  final int totalPrice;
  final String passengerName;
  final String passengerPhone;
  final String paymentMethod;
  final String bookingId;

  const TicketScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
    required this.passengerName,
    required this.passengerPhone,
    required this.paymentMethod,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // Green Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, size: 60, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    'Booking Confirmed!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'ID: $bookingId',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Ticket Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          _detailRow('Bus', bus['name']),
                          _divider(),
                          _detailRow('Seats', selectedSeats.join(', ')),
                          _divider(),
                          _detailRow('Date', '25 Dec 2024'),
                          _divider(),
                          _detailRow(
                            'From → To',
                            '${bus['departure']} → ${bus['arrival']}',
                          ),
                          _divider(),
                          _detailRow('Passenger', passengerName),
                          _divider(),
                          _detailRow(
                            'Total Paid',
                            '₹$totalPrice',
                            isBold: true,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // QR Code Section
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.qr_code, size: 150),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Show this QR to Conductor',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _btn(
                            'Download',
                            Icons.download,
                            Colors.blue,
                            () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _btn(
                            'Share',
                            Icons.share,
                            Colors.green,
                            () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Home Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (r) => false,
                        ),
                        icon: const Icon(Icons.home),
                        label: const Text('Back to Home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: 16,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, thickness: 1);
  }

  Widget _btn(String text, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}
