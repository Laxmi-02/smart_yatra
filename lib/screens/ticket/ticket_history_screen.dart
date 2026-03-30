import 'package:flutter/material.dart';
import '../booking/booking_details_screen.dart';

class TicketHistoryScreen extends StatelessWidget {
  const TicketHistoryScreen({super.key});

  // Sample ticket data (Baad mein Firebase/API se lenge)
  List<Map<String, dynamic>> getTickets() {
    return [
      {
        'pnr': 'SY12345678',
        'busNumber': 'DL-1234',
        'busName': 'Raj Express',
        'from': 'Delhi',
        'to': 'Jaipur',
        'date': '25 Dec 2024',
        'departureTime': '10:30 AM',
        'arrivalTime': '04:30 PM',
        'operator': 'Sharma Travels',
        'busType': 'AC Sleeper',
        'passengers': [
          {'name': 'Rahul Kumar', 'age': 28, 'gender': 'Male', 'seat': 'A12'},
          {
            'name': 'Priya Sharma',
            'age': 26,
            'gender': 'Female',
            'seat': 'A13'
          },
        ],
        'totalFare': 1300.0,
        'paymentMethod': 'UPI (GPay)',
        'status': 'Confirmed',
      },
      {
        'pnr': 'SY87654321',
        'busNumber': 'MH-5678',
        'busName': 'Mumbai Express',
        'from': 'Mumbai',
        'to': 'Pune',
        'date': '20 Dec 2024',
        'departureTime': '08:00 AM',
        'arrivalTime': '11:30 AM',
        'operator': 'National Travels',
        'busType': 'AC Seater',
        'passengers': [
          {'name': 'Amit Patel', 'age': 32, 'gender': 'Male', 'seat': 'B5'},
        ],
        'totalFare': 450.0,
        'paymentMethod': 'Card',
        'status': 'Confirmed',
      },
      {
        'pnr': 'SY11223344',
        'busNumber': 'KA-9012',
        'busName': 'Bangalore Deluxe',
        'from': 'Bangalore',
        'to': 'Chennai',
        'date': '15 Nov 2024',
        'departureTime': '09:00 PM',
        'arrivalTime': '05:00 AM',
        'operator': 'KPN Travels',
        'busType': 'Volvo AC Sleeper',
        'passengers': [
          {'name': 'Sneha Reddy', 'age': 25, 'gender': 'Female', 'seat': 'C8'},
          {'name': 'Karthik Rao', 'age': 27, 'gender': 'Male', 'seat': 'C9'},
        ],
        'totalFare': 1100.0,
        'paymentMethod': 'Net Banking',
        'status': 'Cancelled',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tickets = getTickets();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: tickets.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No Bookings Yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Book your first bus ticket now!',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Search Buses'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return _buildTicketCard(context, ticket);
              },
            ),
    );
  }

  Widget _buildTicketCard(BuildContext context, Map<String, dynamic> ticket) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PNR & Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PNR: ${ticket['pnr']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ticket['status'] == 'Confirmed'
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ticket['status'],
                    style: TextStyle(
                      color: ticket['status'] == 'Confirmed'
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Route
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket['from'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        ticket['departureTime'],
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, color: Colors.blue),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket['to'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        ticket['arrivalTime'],
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Bus Info
            Text(
              '${ticket['busName']} • ${ticket['busType']}',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 5),
            Text(
              'Date: ${ticket['date']}',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 5),
            Text(
              'Passengers: ${ticket['passengers'].length}',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 10),

            // Fare & Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${ticket['totalFare'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                // ✅ View Details Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingDetailsScreen(
                          pnr: ticket['pnr'],
                          busNumber: ticket['busNumber'],
                          busName: ticket['busName'],
                          from: ticket['from'],
                          to: ticket['to'],
                          date: ticket['date'],
                          departureTime: ticket['departureTime'],
                          arrivalTime: ticket['arrivalTime'],
                          operator: ticket['operator'],
                          busType: ticket['busType'],
                          passengers: List<Map<String, dynamic>>.from(
                              ticket['passengers']),
                          totalFare: ticket['totalFare'],
                          paymentMethod: ticket['paymentMethod'],
                          bookingStatus: ticket['status'],
                        ),
                      ),
                    );
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
