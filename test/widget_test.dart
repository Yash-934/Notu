
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:notu/main.dart';

void main() {
  testWidgets('App shows a list of books', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const NOTU(),
      ),
    );

    // Verify that the app title is displayed.
    expect(find.text('NOTU'), findsOneWidget);
  });
}
