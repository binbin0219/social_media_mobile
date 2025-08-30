import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/api/api_client.dart';
import 'package:social_media_mobile/screens/home_page.dart';
import 'package:social_media_mobile/screens/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late ApiClient api;

Future<void> main() async {
  await dotenv.load(); // Load the .env file
  api = await ApiClient.create();
  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
