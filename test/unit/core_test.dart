import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/core.dart';

void main() {
  testWidgets(
    'Core app has an app bar with the app title',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Core(title: 'Timely Essence'),
        ),
      );

      final finder = find.byType(AppBar);

      expect(finder, findsOneWidget);

      AppBar appBar = finder.evaluate().first.widget as AppBar;
      Text appBarTitle = appBar.title as Text;

      expect(appBarTitle.data, 'Timely Essence');
    },
  );

  testWidgets('Application has three pages', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Core(title: 'Timely Essence'),
      ),
    );

    final finder = find.byType(PageView);

    expect(finder, findsOneWidget);

    PageView pageView = finder.evaluate().first.widget as PageView;
    SliverChildDelegate pageViewDelegate = pageView.childrenDelegate;
    int? childrenCount = pageViewDelegate.estimatedChildCount;

    expect(childrenCount, 3);
  });

  testWidgets('There is a bottom navigation bar with three items',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Core(
          title: 'Timely Essence',
        ),
      ),
    );

    final finder = find.byType(BottomNavigationBar);

    expect(finder, findsOneWidget);

    BottomNavigationBar bar =
        finder.evaluate().first.widget as BottomNavigationBar;
    int barItemCount = bar.items.length;

    expect(barItemCount, 3);
  });

  testWidgets(
      'The bottom navigation bar has a timer, stopwatch and settings item',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Core(
          title: 'Timely Essence',
        ),
      ),
    );

    final finder = find.byType(BottomNavigationBar);

    expect(finder, findsOneWidget);

    BottomNavigationBar bar =
        finder.evaluate().first.widget as BottomNavigationBar;
    int barItemCount = bar.items.length;

    expect(barItemCount, 3);

    List<BottomNavigationBarItem> barItems = bar.items;
    bool foundTimer = false;
    bool foundStopwatch = false;
    bool foundSettings = false;

    barItems.forEach((element) {
      BottomNavigationBarItem barItem = element;
      switch (barItem.label) {
        case 'Timer':
          foundTimer = true;
          break;
        case 'Stopwatch':
          foundStopwatch = true;
          break;
        case 'Settings':
          foundSettings = true;
          break;
      }

      Icon barItemIcon = barItem.icon as Icon;
      expect(barItemIcon.semanticLabel?.isNotEmpty, true,
          reason: 'Icon should have a semantic label');
    });

    expect(foundTimer, true);
    expect(foundStopwatch, true);
    expect(foundSettings, true);
  });

  group('Selecting bottom navigation bar items', () {
    testWidgets(
      'Selecting timer bar item shows timer page',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Core(title: 'Timely Essence'),
          ),
        );

        // Click on the timer navigation bar item
        await tester.tap(
          find.byIcon(Icons.timer),
        );
        await tester.pumpAndSettle();

        // Confirm the page moved to the timer page
        final timerPageFinder = find.byKey(
          Key('timerPage'),
        );
        expect(
          timerPageFinder,
          findsOneWidget,
          reason:
              'Timer navigation bar item should transition the page to the timer page',
        );

        // Confirm the bottom navigation bar has updated the selected index
        final bottomNavigationBar = find.byType(BottomNavigationBar);

        expect(
          bottomNavigationBar,
          findsOneWidget,
          reason: 'Bottom navigation bar should exist on next page',
        );

        BottomNavigationBar bottomNavBar =
            bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;

        expect(
          bottomNavBar.currentIndex,
          0,
          reason:
              'Bottom navigation bar index should now match the timer index',
        );
      },
    );
    testWidgets(
      'Selecting stopwatch bar item shows stopwatch page',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Core(title: 'Timely Essence'),
          ),
        );

        // Click on the stopwatch navigation bar item
        await tester.tap(
          find.byIcon(Icons.timelapse_rounded),
        );
        await tester.pumpAndSettle();

        // Confirm the page moved to the stopwatch page
        final stopwatchPageFinder = find.byKey(
          Key('stopwatchPage'),
        );
        expect(
          stopwatchPageFinder,
          findsOneWidget,
          reason:
              'Stopwatch navigation bar item should transition the page to the stopwatch page',
        );

        // Confirm the bottom navigation bar has updated the selected index
        final bottomNavigationBar = find.byType(BottomNavigationBar);

        expect(
          bottomNavigationBar,
          findsOneWidget,
          reason: 'Bottom navigation bar should exist on next page',
        );

        BottomNavigationBar bottomNavBar =
            bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;

        expect(
          bottomNavBar.currentIndex,
          1,
          reason:
              'Bottom navigation bar index should now match the stopwatch index',
        );
      },
    );
    testWidgets(
      'Selecting settings bar item shows settings page',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Core(title: 'Timely Essence'),
          ),
        );

        // Click on the settings navigation bar item
        await tester.tap(
          find.byIcon(Icons.settings),
        );
        await tester.pumpAndSettle();

        // Confirm the page moved to the settings page
        final ssettingsPageFinder = find.byKey(
          Key('settingsPage'),
        );
        expect(
          ssettingsPageFinder,
          findsOneWidget,
          reason:
              'Settings navigation bar item should transition the page to the settings page',
        );

        // Confirm the bottom navigation bar has updated the selected index
        final bottomNavigationBar = find.byType(BottomNavigationBar);

        expect(
          bottomNavigationBar,
          findsOneWidget,
          reason: 'Bottom navigation bar should exist on next page',
        );

        BottomNavigationBar bottomNavBar =
            bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;

        expect(
          bottomNavBar.currentIndex,
          2,
          reason:
              'Bottom navigation bar index should now match the settings index',
        );
      },
    );
  });
}
