// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  test('Rating number should be shown', () {
    Item item = Item(name: "Really Cool Band", name2: "03/01/2024", name3: "12:00 PM", rating: 0);
    expect(item.returnRating(), 0);
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListItem has two texts', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListItem(
                item: Item(name: "test", name2: "test2", name3: "test3",rating: 0),
                completed: true,
                onListChanged: (Item item, bool completed) {},
                onDeleteItem: (Item item) {}))));
    final textFinder = find.text('test');
    final textFinder2 = find.text('test2');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
    expect(textFinder2, findsOneWidget);
  });

  /*testWidgets('ToDoListItem has a Circle Avatar with abbreviation',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListItem(
                item: Item(name: "test", name2: "test2", rating: 0),
                completed: true,
                onListChanged: (Item item, bool completed) {},
                onDeleteItem: (Item item) {}))));
    final abbvFinder = find.text('t');
    final avatarFinder = find.byType(CircleAvatar);

    CircleAvatar circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(abbvFinder, findsOneWidget);
    expect(circ.backgroundColor, Colors.black54);
    expect(ctext.data, "t");
  });*/

  testWidgets('Default Concert List has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(ToDoListItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to Concert List', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byKey(const Key('AddButton')));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byKey(const Key('ConcertField')), 'band');
    await tester.pump();
    expect(find.text("band"), findsOneWidget);

    await tester.enterText(find.byKey(const Key('DateField')), 'day');
    await tester.pump();
    expect(find.text("day"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("band"), findsOneWidget);
    expect(find.text("day"), findsOneWidget);

    final listItemFinder = find.byType(ToDoListItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  
  testWidgets('Selected rating updates item rating', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    await tester.tap(find.byKey(const Key("RatingButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('RatingDropDown')));
    await tester.pumpAndSettle();

    final dropdownItem = find.text('five').last;

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();
  });

}
