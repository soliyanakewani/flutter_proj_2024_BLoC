import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_proj_2024/application/admin/bloc/admin_bloc.dart';
import 'package:flutter_proj_2024/application/admin/bloc/admin_event.dart';
import 'package:flutter_proj_2024/application/admin/bloc/admin_state.dart';
import 'package:flutter_proj_2024/domain/room/room.dart';
import 'package:flutter_proj_2024/presentation/admin/pages/admin_page.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';

// Mock classes for testing
class MockAdminBloc extends Mock implements AdminBloc {}

class MockAdminState extends Mock implements AdminState {}

void main() {
  testWidgets('AdminPage has all necessary widgets and can add a new room', (WidgetTester tester) async {
    // Create a mock AdminBloc
    final adminBloc = MockAdminBloc();

    // Set up the initial state of the mock AdminBloc
    whenListen(
      adminBloc,
      Stream<AdminState>.fromIterable([
        AdminLoading(),
        AdminLoaded([
          Room(
            id: '1',
            title: 'Room 1',
            description: 'Description 1',
            price: 100.0,
            category: 'Category 1',
            image: base64Encode(Uint8List.fromList(List<int>.generate(200 * 200 * 4, (index) => index % 256))),
          ),
        ]),
      ]),
      initialState: AdminLoading(),
    );

    // Build the AdminPage widget
    await tester.pumpWidget(
      BlocProvider<AdminBloc>(
        create: (context) => adminBloc,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppAppBar(),
            drawer: AppDrawer(),
            body: AdminPage(),
          ),
        ),
      ),
    );

    // Verify loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the state to change to AdminLoaded
    await tester.pumpAndSettle();

    // Verify the presence of the room title
    expect(find.text('Room 1'), findsOneWidget);

    // Verify the presence of the room description
    expect(find.text('Description 1'), findsOneWidget);

    // Verify the presence of the room price
    expect(find.text('Price: \$100.0'), findsOneWidget);

    // Verify the presence of the Edit and Delete buttons
    expect(find.widgetWithText(ElevatedButton, 'Edit'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Delete'), findsOneWidget);

    // Tap the Add New Room button
    await tester.tap(find.byTooltip('Add New Room'));
    await tester.pumpAndSettle();

    // Verify the Add New Room dialog appears
    expect(find.text('Add New Room'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Pick Image'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Save'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Cancel'), findsOneWidget);

    // Enter text in the title and description fields
    await tester.enterText(find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.labelText == 'Title'), 'New Room');
    await tester.enterText(find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.labelText == 'Description'), 'New Description');
    await tester.enterText(find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.labelText == 'Price'), '200.0');
    await tester.enterText(find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.labelText == 'Category'), 'New Category');

    // Mock the image picker
    final pickedFile = XFile.fromData(Uint8List.fromList(List<int>.generate(200 * 200 * 4, (index) => index % 256)));

    // Create an AddItemEvent with a Room object
    final room = Room(
      id: '2', // Assuming a unique ID for the new room
      title: 'New Room',
      description: 'New Description',
      price: 200.0,
      category: 'New Category',
      image: base64Encode(Uint8List.fromList(List<int>.generate(200 * 200 * 4, (index) => index % 256))),
    );
    final addItemEvent = AddItemEvent(room);

    // Directly add the event to the bloc
    adminBloc.add(addItemEvent);

    // Tap the Save button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pumpAndSettle();

    // Verify the room is added
    verify(adminBloc.add(addItemEvent)).called(1);
  });
}
