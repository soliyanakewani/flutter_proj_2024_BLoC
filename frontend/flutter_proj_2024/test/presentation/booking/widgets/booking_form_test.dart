import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/presentation/booking/widgets/booking_form.dart';

void main() {
  testWidgets('BookingCard has all necessary widgets', (WidgetTester tester) async {
    // Create a Booking instance with sample data.
    final booking = Booking(
      title: 'fancy room',
      category: 'VIP',
      id: '1',
      description: 'Test Booking Description',
      price: 100,
      image: base64Encode((List<int>.generate(200 * 200 * 4, (index) => index % 256))),
    );

    // Callback function for the booking button.
    void showDatePicker() {
      // This is a stub function for testing purposes.
    }

    // Build the BookingCard widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BookingCard(
            booking: booking,
            showDatePickerCallback: showDatePicker,
          ),
        ),
      ),
    );

    // Verify the presence of the image.
    expect(find.byType(Image), findsOneWidget);

    // Verify the presence of the description text.
    expect(find.text('Test Booking Description'), findsOneWidget);

    // Verify the presence of the price text.
    expect(find.text('Price: \$100.0'), findsOneWidget);

    // Verify the presence of the booking button.
    expect(find.widgetWithText(ElevatedButton, 'BOOK'), findsOneWidget);
  });
}
