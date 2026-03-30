import 'package:flutter/material.dart';
import 'passenger_details.dart';

class SeatSelection extends StatefulWidget {
  final Map<String, dynamic> bus;

  const SeatSelection({super.key, required this.bus});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  final List<int> _selectedSeats = [];
  final int _totalRows = 12;
  final List<int> _occupiedSeats = [
    3,
    7,
    12,
    15,
    18,
    22,
  ]; // Sample occupied seats

  int get _seatPrice => widget.bus['price'] as int;
  int get _totalPrice => _selectedSeats.length * _seatPrice;

  String _getSeatLabel(int seatNumber) {
    return seatNumber.toString();
  }

  bool _isSeatOccupied(int seatNumber) {
    return _occupiedSeats.contains(seatNumber);
  }

  void _toggleSeat(int seatNumber) {
    setState(() {
      if (_selectedSeats.contains(seatNumber)) {
        _selectedSeats.remove(seatNumber);
      } else {
        if (_selectedSeats.length < 6) {
          _selectedSeats.add(seatNumber);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Maximum 6 seats can be booked'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Seats'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Bus Info Header
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
                      widget.bus['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.bus['type'],
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                Text(
                  '₹$_seatPrice/seat',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          // Legend
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem('Available', Colors.grey.shade300),
                _buildLegendItem('Selected', Colors.green),
                _buildLegendItem('Occupied', Colors.red.shade300),
              ],
            ),
          ),

          // Seat Layout
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Driver Area
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_bus,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Driver',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Seats Grid
                    ...List.generate(_totalRows, (rowIndex) {
                      return _buildSeatRow(rowIndex + 1);
                    }),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Summary
          if (_selectedSeats.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedSeats.length} Seat${_selectedSeats.length > 1 ? 's' : ''} Selected',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹$_totalPrice',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PassengerDetails(
                              bus: widget.bus,
                              selectedSeats: List.from(_selectedSeats),
                              totalPrice: _totalPrice,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildSeatRow(int rowNum) {
    int seat1 = (rowNum * 4) - 3;
    int seat2 = (rowNum * 4) - 2;
    int seat3 = (rowNum * 4) - 1;
    int seat4 = (rowNum * 4);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSeat(seat1),
          _buildSeat(seat2),
          const SizedBox(width: 30), // Aisle
          _buildSeat(seat3),
          _buildSeat(seat4),
        ],
      ),
    );
  }

  Widget _buildSeat(int seatNumber) {
    bool isSelected = _selectedSeats.contains(seatNumber);
    bool isOccupied = _isSeatOccupied(seatNumber);

    Color seatColor;
    if (isOccupied) {
      seatColor = Colors.red.shade300;
    } else if (isSelected) {
      seatColor = Colors.green;
    } else {
      seatColor = Colors.grey.shade300;
    }

    return GestureDetector(
      onTap: isOccupied ? null : () => _toggleSeat(seatNumber),
      child: Container(
        width: 45,
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green.shade700 : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            _getSeatLabel(seatNumber),
            style: TextStyle(
              color: isOccupied ? Colors.white70 : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
