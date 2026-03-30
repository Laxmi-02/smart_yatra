import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'title': 'Booking Confirmed!',
      'message':
          'Your ticket from Delhi to Jaipur has been confirmed. PNR: SY12345678',
      'type': 'booking',
      'time': '2 hours ago',
      'isRead': false,
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'id': 2,
      'title': 'Journey Reminder',
      'message':
          'Your bus from Mumbai to Pune departs tomorrow at 8:00 AM. Don\'t forget!',
      'type': 'reminder',
      'time': '5 hours ago',
      'isRead': false,
      'icon': Icons.notifications_active,
      'color': Colors.orange,
    },
    {
      'id': 3,
      'title': 'Special Offer!',
      'message':
          'Get 20% off on your next booking. Use code: SMART20. Valid till 31st Dec.',
      'type': 'offer',
      'time': '1 day ago',
      'isRead': true,
      'icon': Icons.local_offer,
      'color': Colors.purple,
    },
    {
      'id': 4,
      'title': 'Payment Successful',
      'message': '₹1300 has been received for your booking. Thank you!',
      'type': 'payment',
      'time': '2 days ago',
      'isRead': true,
      'icon': Icons.payment,
      'color': Colors.blue,
    },
    {
      'id': 5,
      'title': 'Bus Delayed',
      'message':
          'Your bus DL-1234 is delayed by 15 minutes. New departure: 10:45 AM',
      'type': 'alert',
      'time': '3 days ago',
      'isRead': true,
      'icon': Icons.warning,
      'color': Colors.red,
    },
    {
      'id': 6,
      'title': 'Ticket Cancelled',
      'message':
          'Your ticket SY87654321 has been cancelled. Refund will be processed in 5-7 days.',
      'type': 'cancellation',
      'time': '5 days ago',
      'isRead': true,
      'icon': Icons.cancel,
      'color': Colors.grey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount =
        notifications.where((n) => !(n['isRead'] as bool)).length;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          if (unreadCount > 0)
            Badge(
              label: Text('$unreadCount'),
              backgroundColor: Colors.red,
              child: IconButton(
                icon: const Icon(Icons.mark_email_unread, color: Colors.white),
                onPressed: _markAllAsRead,
                tooltip: 'Mark all as read',
              ),
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: _clearAllNotifications,
            tooltip: 'Clear all',
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We\'ll notify you when something arrives',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Notification Stats
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        Icons.notifications,
                        '${notifications.length}',
                        'Total',
                        Colors.white,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildStatItem(
                        Icons.mark_email_unread,
                        '$unreadCount',
                        'Unread',
                        Colors.white,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildStatItem(
                        Icons.check_circle,
                        '${notifications.length - unreadCount}',
                        'Read',
                        Colors.white,
                      ),
                    ],
                  ),
                ),

                // Filter Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilterChip(
                          label: const Text('All'),
                          selected: true,
                          onSelected: (value) {},
                          backgroundColor: Colors.white,
                          selectedColor: Colors.blue.shade100,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilterChip(
                          label: const Text('Unread'),
                          selected: false,
                          onSelected: (value) {},
                          backgroundColor: Colors.white,
                          selectedColor: Colors.blue.shade100,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilterChip(
                          label: const Text('Offers'),
                          selected: false,
                          onSelected: (value) {},
                          backgroundColor: Colors.white,
                          selectedColor: Colors.blue.shade100,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Notifications List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(notifications[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatItem(
      IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    bool isRead = notification['isRead'];

    return Dismissible(
      key: Key(notification['id'].toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          notifications.removeAt(notifications.indexOf(notification));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification deleted'),
            backgroundColor: Colors.red,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: isRead ? Colors.white : Colors.blue.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (notification['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              notification['icon'] as IconData,
              color: notification['color'] as Color,
              size: 24,
            ),
          ),
          title: Text(
            notification['title'],
            style: TextStyle(
              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                notification['message'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    notification['time'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: !isRead
              ? Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
          onTap: () {
            setState(() {
              notification['isRead'] = true;
            });
            _showNotificationDetails(notification);
          },
        ),
      ),
    );
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (notification['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    notification['icon'] as IconData,
                    color: notification['color'] as Color,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        notification['time'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              notification['message'],
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            if (notification['type'] == 'offer')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Offer Code: SMART20',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Valid till 31st December 2024',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Offer code copied!'),
                            backgroundColor: Colors.purple,
                          ),
                        );
                      },
                      child: const Text('Use Now'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content:
            const Text('Are you sure you want to delete all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications cleared'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('Clear All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
