import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flight_booking_app/models/flight.dart';

class CartItemWidget extends StatelessWidget {
  final Flight flight;
  final Function() onEdit;
  final Function() onDelete;

  const CartItemWidget({
    super.key,
    required this.flight,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                      DateFormat('HH:mm').format(flight.departureTime),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('HH:mm').format(flight.arrivalTime),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
