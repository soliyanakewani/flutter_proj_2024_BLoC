
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_event.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_state.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';


class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingInitial) {
            context.read<BookingBloc>().add(LoadBookings());
            return Center(child: CircularProgressIndicator());
          } else if (state is BookingLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BookingLoaded) {
            final bookings = state.bookings;

            return bookings.isEmpty
                ? Center(child: Text('No bookings found'))
                : ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return Card(
                        color: const Color.fromARGB(255, 244, 229, 212),
                        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.memory(
                                base64Decode(booking.image),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                booking.title,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 95, 65, 65),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Date: ${booking.bookingDate?.toString().split(' ')[0]}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 95, 65, 65),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _showEditDialog(context, booking);
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 231, 228, 226),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      _confirmDelete(context, booking);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Color.fromARGB(255, 243, 33, 33)),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 231, 228, 226),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          } else if (state is BookingError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, Booking booking) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: booking.bookingDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      final updatedBooking = booking.copyWith(bookingDate: selectedDate);
      context.read<BookingBloc>().add(UpdateBooking(booking.id!, updatedBooking));
    }
  }

  void _confirmDelete(BuildContext context, Booking booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this booking?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                context.read<BookingBloc>().add(DeleteBooking(booking.id!));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}