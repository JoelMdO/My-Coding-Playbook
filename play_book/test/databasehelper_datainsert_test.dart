import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_book/screens/insert.dart';
import 'package:play_book/widgets/button/save_button.dart';
import 'package:play_book/widgets/dropdown/sections.dart';
import 'package:play_book/widgets/textfield/data_insert.dart';

void main() {
  // // Helper method to create the widget under test
  testWidgets('InsertData widget test', (WidgetTester tester) async {
    // Build the InsertData widget
    await tester.pumpWidget(const InsertData());

    // Verify the AppBar title and image
    expect(find.text('Playbook'), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsOneWidget);

    // Verify the presence of section dropdown
    expect(find.text('Select section'), findsOneWidget);
    expect(find.byType(Sections), findsOneWidget);

    // Verify the presence of text fields
    expect(find.byType(DataInsertField), findsNWidgets(3));

    // Verify the Save button
    expect(find.byType(SaveButton), findsOneWidget);

    // Optionally, interact with the widgets to verify behavior
    // e.g., enter text into text fields and press the save button
    await tester.enterText(find.byType(DataInsertField).at(0), 'Test Flutter');
    await tester.enterText(
        find.byType(DataInsertField).at(1), 'Flutter Code Tested');
    await tester.enterText(
        find.byType(DataInsertField).at(2), 'Introduction to Mathematics');

    await tester.dragUntilVisible(
        find.byType(SaveButton), // what you want to find
        find.byType(Column),
        // widget you want to scroll
        const Offset(0, 900) // delta to move
        );
    await tester.tap(find.byType(SaveButton));

    await tester.pump(); // Rebuild the widget after the state has changed

    // Add more expectations as needed, e.g., checking if the data was saved
  });
}
