import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_event.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_state.dart';
import 'package:flutter_proj_2024/infrastructure/booking/data_sources/booking_local_data_source.dart';
import 'package:flutter_proj_2024/infrastructure/booking/repositories/booking_repository_impl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class BookingPage extends StatelessWidget {
  BookingPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Deluxe Room',
      'images': ['lib/assets/images/vip1.jpeg', 'lib/assets/images/vip2.jpeg'],
      'descriptions': ['A luxurious room with a great view.', 'Spacious and comfortable.'],
      'prices': [120, 150]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final db = mongo.Db('mongodb://your_mongo_db_url');
    final bookingCollection = db.collection('bookings');
    final bookingLocalDataSource = BookingLocalDataSource(bookingCollection);
    final bookingRepository = BookingRepositoryImpl(bookingLocalDataSource);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      body: BlocProvider(
        create: (context) => BookingBloc(bookingRepository),
        child: SingleChildScrollView(
          child: Column(
            children: categories.map((category) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '${category['title']}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 95, 65, 65),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 465,
                    child: PageView.builder(
                      itemCount: category['images'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildCard(context, category, index);
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> category, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      color: const Color.fromARGB(255, 244, 229, 212),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              category['images'][index],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Divider(color: Color.fromARGB(255, 208, 188, 188)),
            Text(
              '${category['descriptions'][index]}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 95, 65, 65)),
            ),
            Text(
              'Price: \$${category['prices'][index]}',
              style: const TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    _showDatePickerDialog(context, category, index);
                  },
                  child: Text(
                    'B O O K',
                    style: TextStyle(color: Color.fromARGB(255, 99, 76, 76)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 235, 231, 229)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePickerDialog(BuildContext context, Map<String, dynamic> category, int index) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      context.read<BookingBloc>().add(SelectDateEvent(selectedDate));
      _showConfirmationDialog(context, category, index, selectedDate);
    }
  }

  void _showConfirmationDialog(BuildContext context, Map<String, dynamic> category, int index, DateTime date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: Text('Do you want to book ${category['title']} on ${date.toLocal()}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BookingBloc>().add(BookRoomEvent(category, index, date));
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
