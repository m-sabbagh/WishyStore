// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:wishy_store/Screens/UserScreens/UserNavBar.dart';
// import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/LogInPage.dart';
// import 'package:wishy_store/Widgets/buttonPadding.dart';
// import 'package:wishy_store/main.dart';

// void main() {
//   group('App test', () {
//     IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//     final email = find.byType(TextField).first;
//     final password = find.byType(TextField).last;
//     setUpAll(() async {
//       await Firebase.initializeApp();
//     });
//     testWidgets("full app test", (tester) async {
//       await tester.pumpWidget(WishyStore());
//       await tester.pumpAndSettle();
//       expect(find.byType(LoginScreen), findsOneWidget);
//       await tester.enterText(email, "omariii@gmail.com");
//       await tester.enterText(password, "qwertyuiop159@O");
//       await tester.pumpAndSettle();
//       await tester.tap(find.byType(ButtonPadding));
//       await tester.pumpAndSettle();
//       expect(find.byType(NavigationBarForUser), findsOneWidget);
//     });
//   });
// }
