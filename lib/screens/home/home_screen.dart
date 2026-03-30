import 'package:flutter/material.dart';
import '../search/search_screen.dart';
import '../ticket/ticket_history_screen.dart';
import '../profile/profile_screen.dart';
import '../safety/sos_screen.dart';
import '../tracking/bus_tracking_screen.dart';
import '../help/help_screen.dart';
import '../settings/settings_screen.dart';
import 'notifications/notifications_screen.dart';
import '../offers/offers_screen.dart';
import '../wallet/wallet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SmartYatra'),
        backgroundColor: Colors.blue,
        elevation: 2,
        actions: [
          // ✅ Notification Icon - ADDED
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            tooltip: 'Notifications',
          ),
          // Ticket History Button
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TicketHistoryScreen(),
                ),
              );
            },
            tooltip: 'My Bookings',
          ),
          // Settings Button
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to SmartYatra!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Book your bus journey now',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search, size: 24),
                      label: const Text(
                        'Search Buses',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Quick Services
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // First Row - 3 Cards
                  Row(
                    children: [
                      _buildServiceCard(
                        context,
                        'My Bookings',
                        Icons.history,
                        Colors.blue,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TicketHistoryScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _buildServiceCard(
                        context,
                        'Wallet', // ✅ NEW
                        Icons.account_balance_wallet,
                        Colors.green,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WalletScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      const SizedBox(width: 15),
                      _buildServiceCard(
                        context,
                        'Offers',
                        Icons.local_offer,
                        Colors.green,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OffersScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _buildServiceCard(
                        context,
                        'Track Bus',
                        Icons.location_on,
                        Colors.orange,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BusTrackingScreen(
                                busNumber: 'DL-1234',
                                from: 'Delhi',
                                to: 'Jaipur',
                                departureTime: '10:30 AM',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Second Row - 3 Cards
                  Row(
                    children: [
                      _buildServiceCard(
                        context,
                        'SOS',
                        Icons.warning,
                        Colors.red,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SosScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _buildServiceCard(
                        context,
                        'Help',
                        Icons.help_outline,
                        Colors.purple,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelpSupportScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _buildServiceCard(
                        context,
                        'About',
                        Icons.info_outline,
                        Colors.teal,
                        () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'SmartYatra',
                            applicationVersion: '1.0.0',
                            applicationIcon: const Icon(Icons.directions_bus,
                                size: 50, color: Colors.blue),
                            children: const [
                              Text(
                                  'Your trusted companion for safe and smart bus travel across India.'),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Popular Routes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Routes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildPopularRoute(
                      context, 'Delhi', 'Jaipur', '₹650', '12 Buses'),
                  _buildPopularRoute(
                      context, 'Mumbai', 'Pune', '₹450', '25 Buses'),
                  _buildPopularRoute(
                      context, 'Bangalore', 'Chennai', '₹550', '18 Buses'),
                  _buildPopularRoute(
                      context, 'Delhi', 'Chandigarh', '₹500', '15 Buses'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Recent Searches
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildRecentSearch(context, 'Delhi', 'Jaipur', '20 Dec 2024'),
                  _buildRecentSearch(context, 'Mumbai', 'Goa', '15 Nov 2024'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // SOS Emergency Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SosScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.redAccent],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.sos,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Emergency SOS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Tap for immediate help',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularRoute(
    BuildContext context,
    String from,
    String to,
    String price,
    String buses,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.directions_bus,
            color: Colors.blue,
          ),
        ),
        title: Text(
          '$from → $to',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(buses),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 16,
              ),
            ),
            const Text(
              'onwards',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Searching buses from $from to $to...')),
          );
        },
      ),
    );
  }

  Widget _buildRecentSearch(
    BuildContext context,
    String from,
    String to,
    String date,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.history, color: Colors.grey),
        title: Text('$from → $to'),
        subtitle: Text(date),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
      ),
    );
  }
}
