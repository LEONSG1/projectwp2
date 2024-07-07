import 'dart:async';
import 'dart:math';
import 'package:flight_booking_app/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/screens/home_screen.dart';
// Import PaymentScreen

class YourOrderScreen extends StatefulWidget {
  final List<Flight> cartItems;
  final int adults;

  const YourOrderScreen({
    super.key,
    required this.cartItems,
    required this.adults,
  });

  @override
  _YourOrderScreenState createState() => _YourOrderScreenState();
}

class _YourOrderScreenState extends State<YourOrderScreen> {
  late List<Color> itemColors;

  @override
  void initState() {
    super.initState();
    itemColors = List<Color>.generate(
      widget.cartItems.length,
      (index) => _generateRandomColor(),
    );
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        itemColors = List<Color>.generate(
          widget.cartItems.length,
          (index) => _generateRandomColor(),
        );
      });
    });
  }

  Color _generateRandomColor() {
    return Color(0xFF000000 + Random().nextInt(0xFFFFFF));
  }

  void deleteCartItem(BuildContext context, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('${widget.cartItems[index].airline} removed from your order'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {});
          },
        ),
      ),
    );

    setState(() {
      widget.cartItems.removeAt(index);
      itemColors.removeAt(index);
    });
  }

  Future<void> editCartItem(BuildContext context, int index) async {
    final editedFlight = await Navigator.of(context).push<Flight?>(
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          initialFlight: widget.cartItems[index],
          isEditing: true,
        ),
      ),
    );

    if (editedFlight != null) {
      setState(() {
        widget.cartItems[index] = editedFlight;
        itemColors[index] = _generateRandomColor();
      });
    }
  }

  void navigateToPayment(BuildContext context, Flight flight) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          airline: flight.airline,
          totalPrice: flight.price * widget.adults,
          passengerCount: widget.adults,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final flight = widget.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: itemColors[index],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    flight.airline,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${flight.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Passengers: ${widget.adults}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                editCartItem(context, index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteCartItem(context, index);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              navigateToPayment(context, flight);
                            },
                            style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.blue),
                            ),
                            child: const Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
