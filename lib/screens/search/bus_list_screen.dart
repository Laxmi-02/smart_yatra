import 'package:flutter/material.dart';
import '../booking/seat_selection.dart';

class BusListScreen extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;

  const BusListScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
  });

  // 24-hour ko 12-hour format mein convert karo (AM/PM ke saath)
  String _formatTime(String time24) {
    try {
      final parts = time24.split(':');
      int hour = int.parse(parts[0]);
      String minute = parts[1];

      String period = hour >= 12 ? 'PM' : 'AM';
      int hour12 = hour % 12;
      hour12 = hour12 == 0 ? 12 : hour12;

      return '${hour12.toString().padLeft(2, '0')}:$minute $period';
    } catch (e) {
      return time24;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buses = [
      {
        'name': 'Rajasthan Express',
        'type': 'AC Sleeper',
        'rating': 4.5,
        'seats': 25,
        'price': 850,
        'departure': '22:00',
        'arrival': '06:00',
        'duration': '8h',
      },
      {
        'name': 'Volvo Multi-Axle',
        'type': 'AC Seater',
        'rating': 4.3,
        'seats': 18,
        'price': 650,
        'departure': '23:30',
        'arrival': '07:30',
        'duration': '8h',
      },
      {
        'name': 'Green Travels',
        'type': 'Non-AC Seater',
        'rating': 3.8,
        'seats': 32,
        'price': 450,
        'departure': '21:00',
        'arrival': '05:00',
        'duration': '8h',
      },
      {
        'name': 'Orange Tours',
        'type': 'AC Sleeper',
        'rating': 4.7,
        'seats': 12,
        'price': 950,
        'departure': '20:00',
        'arrival': '04:00',
        'duration': '8h',
      },
      {
        'name': 'Blue Line',
        'type': 'AC Seater',
        'rating': 4.0,
        'seats': 22,
        'price': 550,
        'departure': '22:30',
        'arrival': '06:30',
        'duration': '8h',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Available Buses'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter Coming Soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Route Info Header
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      from,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward, size: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      to,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${buses.length} Buses',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bus List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: buses.length,
              itemBuilder: (context, index) {
                final bus = buses[index];
                return _buildBusCard(context, bus);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusCard(BuildContext context, Map<String, dynamic> bus) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bus Name & Type
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bus['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        bus['type'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                // Rating
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.green),
                      const SizedBox(width: 3),
                      Text(
                        '${bus['rating']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Departure Time (AM/PM format)
                Column(
                  children: [
                    Text(
                      _formatTime(bus['departure']),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Departs',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                // Duration
                Column(
                  children: [
                    Text(
                      bus['duration'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      'Duration',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                // Arrival Time (AM/PM format)
                Column(
                  children: [
                    Text(
                      _formatTime(bus['arrival']),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Arrives',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Seats Available
                Row(
                  children: [
                    Icon(
                      Icons.event_seat,
                      color: bus['seats'] > 20 ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${bus['seats']} seats available',
                      style: TextStyle(
                        color: bus['seats'] > 20 ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // Price & Button
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${bus['price']}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const Text(
                          'per person',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatSelection(bus: bus),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View Seats',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
