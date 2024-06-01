import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_event.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_state.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/presentation/booking/widgets/booking_form.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';


class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

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
            Map<String, List<Booking>> categorizedBookings = {
              'VIP': [],
              'Middle': [],
              'Economy': [],
            };

            for (var booking in bookings) {
              categorizedBookings[booking.category]?.add(booking);
            }

            return SingleChildScrollView(
              child: Column(
                children: categorizedBookings.entries.map((entry) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 95, 65, 65),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (entry.value.isNotEmpty)
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 465,
                            enableInfiniteScroll: true,
                            viewportFraction: 1.0,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                          ),
                          itemCount: entry.value.length,
                          itemBuilder: (BuildContext context, int index, int realIndex) {
                            return _buildCard(context, entry.value[index]);
                          },
                        )
                      else
                        Text('No rooms available for this category'),
                    ],
                  );
                }).toList(),
              ),
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

  void _showDatePickerDialog(BuildContext context, Booking booking) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      // Assuming userProvider is replaced by some auth logic to get the user
      final user = 'example_user@example.com';
      final newBooking = booking.copyWith(bookingDate: selectedDate, user: user);

      context.read<BookingBloc>().add(AddBooking(newBooking));
    }
  }

  Widget _buildCard(BuildContext context, Booking booking) {
    return BookingCard(
      booking: booking,
      showDatePickerCallback: () => _showDatePickerDialog(context, booking),
    );
  }
}