import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/domain/booking/repositories/booking_repository.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';

import 'package:flutter_proj_2024/application/booking/bloc/booking_event.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc(this.bookingRepository) : super(BookingInitial());

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is LoadBookingsEvent) {
      yield BookingLoading();
      try {
        final bookings = await bookingRepository.loadBookings();
        yield BookingLoaded(bookings);
      } catch (e) {
        yield BookingError('Failed to load bookings: $e');
      }
    } else if (event is SelectDateEvent) {
      yield DateSelected(event.selectedDate);
    } else if (event is BookRoomEvent) {
      yield BookingLoading();
      try {
        await bookingRepository.bookRoom(event.category, event.index, event.date);
        yield BookingSuccess();
      } catch (e) {
        yield BookingFailure('Failed to book room: $e');
      }
    }
  }
}
