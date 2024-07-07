import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/screens/bookingconfirmationscreen.dart.dart';
import 'package:flight_booking_app/screens/yourorderscreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final Flight? initialFlight;
  final bool isEditing;

  const HomeScreen({
    super.key,
    this.initialFlight,
    this.isEditing = false,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Flight> _cartItems = [];
  DateTime _departureDate = DateTime.now();
  DateTime? _returnDate;
  int _adults = 1;
  final int _children = 0;
  final int _bags = 0;
  String _travelClass = 'Economy';
  bool _nonstopFlights = false;
  bool _isRoundTrip = true;

  final List<String> _fromCities = [
    'Jakarta',
    'Bandung',
    'Surabaya',
    'Medan',
    'Semarang',
    'Denpasar'
  ];
  final List<String> _toCities = [
    'Jakarta',
    'Bandung',
    'Surabaya',
    'Medan',
    'Semarang',
    'Denpasar'
  ];

  String _selectedFromCity = 'Jakarta';
  String _selectedToCity = 'Bandung';

  final ScrollController _scrollController = ScrollController();
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 100 &&
        !_scrollController.position.outOfRange) {
      if (!_showButtons) {
        setState(() {
          _showButtons = true;
        });
      }
    } else {
      if (_showButtons) {
        setState(() {
          _showButtons = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? _departureDate : _returnDate ?? _departureDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != (isDeparture ? _departureDate : _returnDate)) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  void _toggleTripType() {
    setState(() {
      _isRoundTrip = !_isRoundTrip;
    });
  }

  void _addToCart(Flight flight) {
    setState(() {
      _cartItems.add(flight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 50.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.0),
                  image: const DecorationImage(
                    image: AssetImage('assets/background1.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 450),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'From',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: _selectedFromCity,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFromCity = newValue!;
                          });
                        },
                        items: _fromCities
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'To',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: _selectedToCity,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedToCity = newValue!;
                          });
                        },
                        items: _toCities
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Depart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () => _selectDate(context, true),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      DateFormat.yMd().format(_departureDate),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isRoundTrip) const SizedBox(width: 40),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Passengers',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Adults'),
                                DropdownButton<int>(
                                  value: _adults,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _adults = newValue!;
                                    });
                                  },
                                  items: List.generate(10, (index) => index + 1)
                                      .map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Class',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: _travelClass,
                        onChanged: (String? newValue) {
                          setState(() {
                            _travelClass = newValue!;
                          });
                        },
                        items: <String>['Economy', 'Business']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      SwitchListTile(
                        title: const Text(
                          'Nonstop flights first',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        value: _nonstopFlights,
                        onChanged: (bool value) {
                          setState(() {
                            _nonstopFlights = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingConfirmationScreen(
                                  departureDate: _departureDate,
                                  returnDate: _isRoundTrip ? _returnDate : null,
                                  adults: _adults,
                                  children: _children,
                                  bags: _bags,
                                  travelClass: _travelClass,
                                  nonstopFlights: _nonstopFlights,
                                  fromCity: _selectedFromCity,
                                  toCity: _selectedToCity,
                                  cartItems: _cartItems,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            'Search Flights',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100), // Adjust as needed
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _showButtons ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Transform.translate(
              offset: Offset(0.0, _showButtons ? 0.0 : 50.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle Home button tap
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Home',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YourOrderScreen(
                              cartItems: _cartItems,
                              adults: _adults,
                            ),
                          ),
                        );
                        // Handle Your Order button tap
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Your Order',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
