
import 'package:equatable/equatable.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookings extends BookingEvent {}

class AddBooking extends BookingEvent {
  final Booking booking;

  const AddBooking(this.booking);

  @override
  List<Object?> get props => [booking];
}

class UpdateBooking extends BookingEvent {
  final String id;
  final Booking booking;

  const UpdateBooking(this.id, this.booking);

  @override
  List<Object?> get props => [id, booking];
}

class DeleteBooking extends BookingEvent {
  final String id;

  const DeleteBooking(this.id);

  @override
  List<Object?> get props => [id];
}