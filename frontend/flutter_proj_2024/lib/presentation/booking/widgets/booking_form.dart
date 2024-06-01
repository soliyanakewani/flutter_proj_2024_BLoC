import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback showDatePickerCallback;

  BookingCard({
    required this.booking,
    required this.showDatePickerCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      color: const Color.fromARGB(255, 244, 229, 212),
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.memory(
              base64Decode(booking.image),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Divider(color: Color.fromARGB(255, 208, 188, 188)),
            Text(
              booking.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 95, 65, 65),
              ),
            ),
            Text(
              'Price: \$${booking.price}',
              style: const TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: showDatePickerCallback,
              child: const Text(
                'BOOK',
                style: TextStyle(color: Color.fromARGB(255, 99, 76, 76)),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 235, 231, 229)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}