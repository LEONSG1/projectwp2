import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String airline;
  final double totalPrice;
  final int passengerCount;

  const PaymentScreen({
    super.key,
    required this.airline,
    required this.totalPrice,
    required this.passengerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 400, // Lebar kotak persegi
          padding: const EdgeInsets.all(20),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Airline: $airline',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Passenger Count: $passengerCount',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              const Text(
                'Transaction Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
