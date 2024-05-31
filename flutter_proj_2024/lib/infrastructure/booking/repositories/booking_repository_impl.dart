// booking_repository_impl.dart

import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/domain/booking/repositories/booking_repository.dart';
import 'package:flutter_proj_2024/infrastructure/booking/data_sources/booking_local_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource localDataSource;

  BookingRepositoryImpl(this.localDataSource);

  @override
  Future<List<Booking>> loadBookings() async {
    // Retrieve bookings from the local data source
    return await localDataSource.getBookings();
  }

   @override
  Future<void> bookRoom(Map<String, dynamic> category, int index, DateTime date) async {
   //a new Booking object and add it to the local data source
    final booking = Booking(
      id: 'some_id', 
      userId: 'user_id', 
      roomId: category['roomId'], 
      startDate: date, 
      endDate: date.add(const Duration(days: 1)), 
    );

    await localDataSource.addBooking(booking);
  }


  @override
  Future<void> updateBooking(Booking booking) async {
    // Update booking in the local data source
    await localDataSource.updateBooking(booking);
  }

  @override
  Future<void> deleteBooking(Booking booking) async {
    // Delete booking from the local data source
    await localDataSource.deleteBooking(booking);
  }
}
