
import 'package:bloc/bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_event.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_state.dart';
import 'package:flutter_proj_2024/infrastructure/booking/repositories/booking_repository_impl.dart';



class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) : super(BookingInitial());

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is LoadBookings) {
      yield* _mapLoadBookingsToState();
    } else if (event is AddBooking) {
      yield* _mapAddBookingToState(event);
    } else if (event is UpdateBooking) {
      yield* _mapUpdateBookingToState(event);
    } else if (event is DeleteBooking) {
      yield* _mapDeleteBookingToState(event);
    }
  }

  Stream<BookingState> _mapLoadBookingsToState() async* {
    yield BookingLoading();
    try {
      final bookings = await bookingRepository.getBookings(); // Use the correct method name
      yield BookingLoaded(bookings);
    } catch (e) {
      yield BookingError(e.toString());
    }
  }

  Stream<BookingState> _mapAddBookingToState(AddBooking event) async* {
    try {
      await bookingRepository.addBooking(event.booking); // Use the correct method name
      yield* _mapLoadBookingsToState();
    } catch (e) {
      yield BookingError(e.toString());
    }
  }

  Stream<BookingState> _mapUpdateBookingToState(UpdateBooking event) async* {
    try {
      await bookingRepository.updateBooking(event.id, event.booking);
      yield* _mapLoadBookingsToState();
    } catch (e) {
      yield BookingError(e.toString());
    }
  }

  Stream<BookingState> _mapDeleteBookingToState(DeleteBooking event) async* {
    try {
      await bookingRepository.deleteBooking(event.id);
      yield* _mapLoadBookingsToState();
    } catch (e) {
      yield BookingError(e.toString());
    }
  }
}

