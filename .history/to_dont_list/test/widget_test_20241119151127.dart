// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/flora.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  test('Item abbreviation should be first letter', () {
    const item = Item(name: "add more todos");
    expect(item.abbrev(), "a");
  });
// test did not pass until abbrev method in item was fixed

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: FloraListItem(
                flora: Flora(name: "test", type: FloraType.weed),
                completed: true,
                onListChanged: (Flora item, bool completed) {},
                onDeleteItem: (Flora item) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Flora Item has a starting number of 1',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: FloraListItem(
                flora: Flora(name: "test", type: FloraType.weed),
                completed: true,
                onListChanged: (Flora item, bool completed) {},
                onDeleteItem: (Flora item) {}))));
    final abbvFinder = find.text('1');
    final avatarFinder = find.byType(ElevatedButton);

    ElevatedButton circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    //expect(abbvFinder, findsOneWidget);
    //expect(circ.backgroundColor, Colors.black54);
    expect(ctext.data, "1");
  });

  testWidgets('Clicking "delete" icon deletes an item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    await tester.enterText(find.byType(TextField), 'hi');
    await tester.pump();
    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    await tester.tap(find.byKey(const Key("Delete")));
    await tester.pump();
    expect(find.byType(FloraListItem), findsNothing);
  });

  testWidgets('Default ToDoList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(FloraListItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    final listItemFinder = find.byType(FloraListItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  // One to test the tap and press actions on the items?
}
