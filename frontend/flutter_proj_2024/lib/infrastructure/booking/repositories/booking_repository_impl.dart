import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/infrastructure/booking/data_sources/booking_remote_data_source.dart';


abstract class BookingRepository {
  Future<List<Booking>> getBookings(); // Ensure method name is consistent
  Future<void> addBooking(Booking booking); // Ensure method name is consistent
  Future<void> updateBooking(String id, Booking booking);
  Future<void> deleteBooking(String id);
}


class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Booking>> getBookings() async {
    return await remoteDataSource.fetchBookings(); // Ensure method names match
  }

  @override
  Future<void> addBooking(Booking booking) async {
    await remoteDataSource.postBooking(booking);
  }

  @override
  Future<void> updateBooking(String id, Booking booking) async {
    await remoteDataSource.updateBooking(id, booking);
  }

  @override
  Future<void> deleteBooking(String id) async {
    await remoteDataSource.deleteBooking(id);
  }
}