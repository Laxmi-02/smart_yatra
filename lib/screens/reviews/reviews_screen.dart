import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  final String busName;
  final String operator;
  final String pnr;

  const ReviewsScreen({
    super.key,
    required this.busName,
    required this.operator,
    required this.pnr,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();
  
  int _overallRating = 0;
  int _cleanlinessRating = 0;
  int _comfortRating = 0;
  int _driverRating = 0;
  bool _isLoading = false;

  // Sample existing reviews
  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Amit Sharma',
      'rating': 5,
      'comment': 'Excellent service! Bus was very clean and on time.',
      'date': '2 days ago',
      'avatar': 'AS',
    },
    {
      'name': 'Priya Singh',
      'rating': 4,
      'comment': 'Good experience. Driver was very professional.',
      'date': '1 week ago',
      'avatar': 'PS',
    },
    {
      'name': 'Rahul Verma',
      'rating': 3,
      'comment': 'Average. Bus was delayed by 30 minutes.',
      'date': '2 weeks ago',
      'avatar': 'RV',    },
  ];

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      if (_overallRating == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please give overall rating'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you for your review!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Rate Your Journey'),        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Journey Info Card
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.directions_bus,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.busName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.operator,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),                        ),
                        const SizedBox(height: 5),
                        Text(
                          'PNR: ${widget.pnr}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Rating Form
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rate Your Experience',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Overall Rating
                          _buildRatingSection(
                            'Overall Experience',
                            _overallRating,
                            (value) {
                              setState(() {
                                _overallRating = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          // Cleanliness Rating
                          _buildRatingSection(
                            'Bus Cleanliness',
                            _cleanlinessRating,
                            (value) {                              setState(() {
                                _cleanlinessRating = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          // Comfort Rating
                          _buildRatingSection(
                            'Seat Comfort',
                            _comfortRating,
                            (value) {
                              setState(() {
                                _comfortRating = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          // Driver Rating
                          _buildRatingSection(
                            'Driver Behavior',
                            _driverRating,
                            (value) {
                              setState(() {
                                _driverRating = value;
                              });
                            },
                          ),

                          const SizedBox(height: 25),

                          // Review Text
                          TextFormField(
                            controller: _reviewController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Write Your Review (Optional)',
                              hintText: 'Share your experience...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.blue, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _submitReview,
                              child: const Text(
                                'Submit Review',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Existing Reviews
                          const Text(
                            'Recent Reviews',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),

                          ..._reviews.map((review) => _buildReviewCard(review)).toList(),

                          const SizedBox(height: 20),
                        ],
                      ),                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildRatingSection(String label, int rating, ValueChanged<int> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ...List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 35,
                ),
                onPressed: () => onChanged(index + 1),
              );
            }),
            const SizedBox(width: 10),
            Text(
              rating > 0 ? '$rating/5' : 'Tap to rate',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),      decoration: BoxDecoration(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  review['avatar'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ],                    ),
                  ],
                ),
              ),
              Text(
                review['date'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review['comment'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}