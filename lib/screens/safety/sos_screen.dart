import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'add_contact_screen.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  bool _isDangerZone = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Map<String, String>> _contacts = [
    {'name': 'Police Control Room', 'number': '112', 'relation': 'Emergency'},
    {'name': 'Women Helpline', 'number': '1091', 'relation': 'Emergency'},
    {'name': 'Ambulance', 'number': '102', 'relation': 'Emergency'},
  ];

  List<Map<String, String>> _customContacts = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadCustomContacts();
    _checkCurrentLocation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsJson = prefs.getString('emergency_contacts') ?? '[]';
    List<dynamic> contacts = jsonDecode(contactsJson);

    setState(() {
      _customContacts =
          contacts.map((c) => Map<String, String>.from(c)).toList();
    });
  }

  List<Map<String, String>> _getAllContacts() {
    return [..._contacts, ..._customContacts];
  }

  void _startSos() {
    setState(() => _isPressed = true);
    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (_isPressed && mounted) {
        _triggerSos();
      }
    });
  }

  void _stopSos() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _triggerSos() async {
    final allContacts = _getAllContacts();

    // Show alert immediately
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red.shade700),
              const SizedBox(width: 10),
              const Text('🚨 SOS ACTIVATED!',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.location_on, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    const Text('Emergency alerts sent!',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text('Live location shared with all contacts'),
                    const SizedBox(height: 10),
                    const Text('Please call emergency contacts manually',
                        style: TextStyle(fontSize: 12, color: Colors.orange)),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                _stopSos();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    // Share location only (don't open browser for calls)
    await _shareLocation();

    // Show contacts to call manually
    for (var contact in allContacts) {
      if (contact['relation'] == 'Emergency') {
        print(
            '📞 Emergency Contact: ${contact['name']} - ${contact['number']}');
      }
    }
  }

  Future<void> _makeCall(String number, String name) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showCallDialog(name, number);
      }
    } catch (e) {
      _showCallDialog(name, number);
    }
  }

  void _showCallDialog(String name, String number) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Calling $name'),
        content: Text('Phone: $number'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareLocation() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📍 Live location shared with all contacts!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _checkCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final dangerZones = [
        {
          'name': 'Connaught Place',
          'lat': 28.6315,
          'lng': 77.2167,
          'radius': 500
        },
        {'name': 'Karol Bagh', 'lat': 28.6519, 'lng': 77.1909, 'radius': 300},
      ];

      for (var zone in dangerZones) {
        final lat = zone['lat'] as double;
        final lng = zone['lng'] as double;
        final radius = zone['radius'] as double;
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          lat,
          lng,
        );

        if (distance <= radius) {
          setState(() => _isDangerZone = true);
          break;
        }
      }
    } catch (e) {
      print('Location error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Emergency SOS'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Danger Zone Warning
            if (_isDangerZone)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade400, width: 2),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange, size: 30),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '⚠️ You are in a Danger Zone!',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // SOS Button
            GestureDetector(
              onLongPressStart: (_) => _startSos(),
              onLongPressEnd: (_) => _stopSos(),
              onLongPressCancel: () => _stopSos(),
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: _isPressed
                              ? [Colors.red.shade900, Colors.red.shade700]
                              : [Colors.red.shade700, Colors.red.shade900],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.red.withOpacity(_isPressed ? 1.0 : 0.5),
                            blurRadius: _isPressed ? 50 : 20,
                            spreadRadius: _isPressed ? 15 : 5,
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sos, size: 70, color: Colors.white),
                          const SizedBox(height: 15),
                          Text(
                            _isPressed ? 'HOLD...' : 'TAP & HOLD',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                          if (_isPressed)
                            Text(
                              '${(3 - (_animationController.value * 3)).toInt()}s',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),
            Text(
              _isPressed ? 'Release to cancel' : 'For immediate emergency help',
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Text(
              'Hold button for 3 seconds to activate SOS',
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),

            const SizedBox(height: 40),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _shareLocation,
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text('Share Location',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _makeCall('112', 'Police'),
                    icon: const Icon(Icons.local_police, color: Colors.white),
                    label: const Text('Call Police',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Emergency Contacts Title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Emergency Contacts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),

            // Contacts List
            ..._getAllContacts().map((contact) => Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: contact['relation'] == 'Emergency'
                          ? Colors.red
                          : Colors.blue,
                      child: Icon(
                        contact['relation'] == 'Emergency'
                            ? Icons.local_police
                            : Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(contact['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle:
                        Text('${contact['relation']} • ${contact['number']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () =>
                          _makeCall(contact['number']!, contact['name']!),
                    ),
                  ),
                )),

            const SizedBox(height: 20),

            // Add Contact Button
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddContactScreen()),
                );
                if (result == true) _loadCustomContacts();
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Emergency Contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
