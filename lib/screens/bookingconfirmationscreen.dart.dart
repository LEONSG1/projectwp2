import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/screens/FlightDetailScreen.dart';
import 'package:flight_booking_app/screens/YourOrderScreen.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final DateTime departureDate;
  final DateTime? returnDate;
  final int adults;
  final int children;
  final int bags;
  final String travelClass;
  final bool nonstopFlights;
  final String fromCity;
  final String toCity;
  final List<Flight>
      cartItems; // List untuk menyimpan penerbangan yang ditambahkan ke keranjang

  const BookingConfirmationScreen({
    super.key,
    required this.departureDate,
    required this.returnDate,
    required this.adults,
    required this.children,
    required this.bags,
    required this.travelClass,
    required this.nonstopFlights,
    required this.fromCity,
    required this.toCity,
    required this.cartItems, // Menerima list cartItems dari HomeScreen
  });

  @override
  _BookingConfirmationScreenState createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  late Color _animatedContainerColor;
  late Timer _timer;

  final List<Flight> availableFlights = [
    Flight(
      airline: 'Super Air Jet',
      departureTime: DateTime.now().add(const Duration(hours: 2)),
      arrivalTime: DateTime.now().add(const Duration(hours: 5)),
      price: 70,
      passengerCount: 1,
    ),
    Flight(
      airline: 'Lion Air',
      departureTime: DateTime.now().add(const Duration(hours: 3)),
      arrivalTime: DateTime.now().add(const Duration(hours: 6)),
      price: 80,
      passengerCount: 1,
    ),
    Flight(
      airline: 'Citilink',
      departureTime: DateTime.now().add(const Duration(hours: 3)),
      arrivalTime: DateTime.now().add(const Duration(hours: 6)),
      price: 50,
      passengerCount: 1,
    ),
    Flight(
      airline: 'Pelita Air',
      departureTime: DateTime.now().add(const Duration(hours: 3)),
      arrivalTime: DateTime.now().add(const Duration(hours: 6)),
      price: 65,
      passengerCount: 1,
    ),
    Flight(
      airline: 'Garuda Indonesia',
      departureTime: DateTime.now().add(const Duration(hours: 3)),
      arrivalTime: DateTime.now().add(const Duration(hours: 6)),
      price: 95,
      passengerCount: 1,
    ),
    Flight(
      airline: 'Batik Air',
      departureTime: DateTime.now().add(const Duration(hours: 3)),
      arrivalTime: DateTime.now().add(const Duration(hours: 6)),
      price: 95,
      passengerCount: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animatedContainerColor = Colors.blue; // Warna awal
    _startColorTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Memastikan timer di-cancel saat widget di dispose
    super.dispose();
  }

  void _startColorTimer() {
    const Color startColor = Colors.blue;
    const Color endColor = Colors.red;
    const Duration duration = Duration(seconds: 5);

    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _animatedContainerColor =
            _animatedContainerColor == startColor ? endColor : startColor;
      });
    });
  }

  // Fungsi untuk menambahkan penerbangan ke keranjang
  void addToCart(Flight flight) {
    setState(() {
      widget.cartItems
          .add(flight); // Menambahkan penerbangan ke widget.cartItems
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Flights'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YourOrderScreen(
                    cartItems: widget.cartItems,
                    adults: widget.adults,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            color: _animatedContainerColor,
            height: 30,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Ada Jaminan Harga Termurah untuk tujuan penerbangan yang kamu pilih',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableFlights.length,
              itemBuilder: (context, index) {
                final flight = availableFlights[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              flight.airline,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${flight.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          children: [
                            Icon(Icons.autorenew, size: 16),
                            SizedBox(width: 5),
                            Text(
                              'Reschedule',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.money_off, size: 16),
                            SizedBox(width: 5),
                            Text(
                              'Refund',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Departure - Arrival',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('HH:mm')
                                      .format(flight.departureTime),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.arrow_forward, size: 16),
                                const SizedBox(width: 5),
                                Text(
                                  DateFormat('HH:mm')
                                      .format(flight.arrivalTime),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlightDetailScreen(
                            flight: flight,
                            departureDate: widget.departureDate,

                            adults: widget.adults,
                            children: widget.children,

                            travelClass: widget.travelClass,

                            fromCity: widget.fromCity,
                            toCity: widget.toCity,
                            onAddToCart:
                                addToCart, // Mengirim fungsi addToCart ke FlightDetailScreen
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
