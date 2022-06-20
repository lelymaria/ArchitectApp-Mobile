// // // This is a basic Flutter widget test.
// // //
// // // To perform an interaction with a widget in your test, use the WidgetTester
// // // utility that Flutter provides. For example, you can send tap and scroll
// // // gestures. You can also use WidgetTester to find child widgets in the widget
// // // tree, read text, and verify that the values of widget properties are correct.

// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';

// // import 'package:architect_app/main.dart';

// // void main() {
// //   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
// //     // Build our app and trigger a frame.
// //     await tester.pumpWidget(MyApp());

// //     // Verify that our counter starts at 0.
// //     expect(find.text('0'), findsOneWidget);
// //     expect(find.text('1'), findsNothing);

// //     // Tap the '+' icon and trigger a frame.
// //     await tester.tap(find.byIcon(Icons.add));
// //     await tester.pump();

// //     // Verify that our counter has incremented.
// //     expect(find.text('0'), findsNothing);
// //     expect(find.text('1'), findsOneWidget);
// //   });
// // }

// import 'dart:convert';

// import 'package:architect_app/utils/http_headers.dart';
// import 'package:http/http.dart' as http;
// import 'package:architect_app/models/preferences/auth_preference.dart';
// import 'package:architect_app/models/responses/get_project_guest.dart';

// void main() async{
//   final String baseUrl = "http://arsitekco.proyek.ti.polindra.ac.id/api";

//    Future<List<ProjectGuest>> getProject() async {
//     print("get projek");
//     final response = await http
//         .get(Uri.parse("$baseUrl/project"),
//             headers: await HttpHeaders.headers())
//         .timeout(Duration(seconds: 120));

//     print(response.statusCode);
//     final data = jsonDecode(response.body);
//     GetProjectGuestResponse record = GetProjectGuestResponse.fromJson(data);

//     if (response.statusCode == 200) {
//       return record.data;
//     } else {
//       return record.data;
//     }
//   }

//   await getProject();
// }