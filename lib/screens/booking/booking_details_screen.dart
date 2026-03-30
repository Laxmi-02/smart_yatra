import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../reviews/reviews_screen.dart';
import '../ticket/cancellation_receipt_screen.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String pnr;
  final String busNumber;
  final String busName;
  final String from;
  final String to;
  final String date;
  final String departureTime;
  final String arrivalTime;
  final String operator;
  final String busType;
  final List<Map<String, dynamic>> passengers;
  final double totalFare;
  final String paymentMethod;
  final String bookingStatus;
  final String boardingPoint;
  final String droppingPoint;

  const BookingDetailsScreen({
    super.key,
    required this.pnr,
    required this.busNumber,
    required this.busName,
    required this.from,
    required this.to,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
    required this.operator,
    required this.busType,
    required this.passengers,
    required this.totalFare,
    required this.paymentMethod,
    this.bookingStatus = 'Confirmed',
    this.boardingPoint = 'ISBT Kashmere Gate, Delhi',
    this.droppingPoint = 'Sindhi Camp, Jaipur',
  });

  Future<void> _shareTicket(BuildContext context) async {
    await Share.share(
      ' SmartYatra E-Ticket\n'
      'PNR: $pnr\n'
      'Bus: $busName ($busNumber)\n'
      'From: $from → To: $to\n'
      'Date: $date at $departureTime\n'
      'Passengers: ${passengers.length}\n'
      'Status: $bookingStatus\n'
      '\nBooked via SmartYatra App',
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Ticket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to cancel this ticket?'),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Refund Details:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text('Total Fare: ₹${totalFare.toStringAsFixed(0)}'),
                  Text(
                      'Cancellation Charges: ₹${(totalFare * 0.25).toStringAsFixed(0)}'),
                  const Divider(),
                  Text(
                    'Refund Amount: ₹${(totalFare * 0.75).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Refund will be processed in 5-7 business days',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to Cancellation Receipt
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CancellationReceiptScreen(
                    pnr: pnr,
                    busName: busName,
                    from: from,
                    to: to,
                    date: date,
                    totalFare: totalFare,
                    refundAmount: totalFare * 0.75,
                    cancellationCharges: totalFare * 0.25,
                    cancellationId:
                        'CXL${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                    refundStatus: 'Processing',
                    cancellationDate: DateTime.now(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => _shareTicket(context),
            tooltip: 'Share Ticket',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // PNR & Status Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: bookingStatus == 'Confirmed'
                      ? [Colors.green, Colors.green.shade700]
                      : [Colors.red, Colors.red.shade700],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: (bookingStatus == 'Confirmed'
                            ? Colors.green
                            : Colors.red)
                        .withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PNR Number',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                          Text(
                            pnr,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          bookingStatus,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.qr_code, size: 60, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Journey Details
            _buildSectionTitle('Journey Details'),
            _buildInfoCard(
              icon: Icons.directions_bus,
              title: '$busName',
              subtitle: '$busNumber • $busType',
              color: Colors.blue,
            ),
            _buildInfoCard(
              icon: Icons.person,
              title: operator,
              subtitle: 'Bus Operator',
              color: Colors.purple,
            ),

            const SizedBox(height: 15),

            // Route Details
            _buildSectionTitle('Route'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildRoutePoint(from, departureTime, true),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                        ),
                        const Icon(Icons.arrow_forward,
                            color: Colors.blue, size: 20),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildRoutePoint(to, arrivalTime, false),
                  const Divider(),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Passengers
            _buildSectionTitle('Passengers (${passengers.length})'),
            ...passengers.asMap().entries.map((entry) {
              int index = entry.key;
              var passenger = entry.value;
              return _buildPassengerCard(passenger, index + 1);
            }).toList(),

            const SizedBox(height: 15),

            // Boarding & Dropping
            _buildSectionTitle('Boarding & Dropping'),
            _buildInfoCard(
              icon: Icons.location_on,
              title: 'Boarding Point',
              subtitle: boardingPoint,
              color: Colors.green,
            ),
            _buildInfoCard(
              icon: Icons.flag,
              title: 'Dropping Point',
              subtitle: droppingPoint,
              color: Colors.orange,
            ),

            const SizedBox(height: 15),

            // Fare Details
            _buildSectionTitle('Fare Details'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildFareRow(
                      'Base Fare', '₹${(totalFare * 0.85).toStringAsFixed(0)}'),
                  _buildFareRow('Taxes & Charges',
                      '₹${(totalFare * 0.10).toStringAsFixed(0)}'),
                  _buildFareRow('Convenience Fee',
                      '₹${(totalFare * 0.05).toStringAsFixed(0)}'),
                  const Divider(),
                  _buildFareRow(
                      'Total Paid', '₹${totalFare.toStringAsFixed(0)}',
                      isTotal: true),
                  const SizedBox(height: 5),
                  Text(
                    'Payment: $paymentMethod',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // ✅ Write Review Button - ADDED
                  if (bookingStatus == 'Confirmed')
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewsScreen(
                                busName: busName,
                                operator: operator,
                                pnr: pnr,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.star, color: Colors.orange),
                        label: const Text(
                          'Write Review',
                          style: TextStyle(color: Colors.orange),
                        ),
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.orange, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                  if (bookingStatus == 'Confirmed') const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Download Coming Soon!')),
                            );
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Download'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _shareTicket(context),
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: bookingStatus == 'Confirmed'
                          ? () => _showCancelDialog(context)
                          : null,
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancel Ticket'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        disabledBackgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutePoint(String location, String time, bool isStart) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isStart ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPassengerCard(Map<String, dynamic> passenger, int number) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(
              '$number',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  passenger['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  '${passenger['age']} yrs • ${passenger['gender']} • Seat ${passenger['seat']}',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
