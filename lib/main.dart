import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:social_media_mobile/screens/login_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
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
        '/home': (context) => const MyHomePage(title: "Home"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  dynamic _fetchedData = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<dynamic> _fetchDataFromApi(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Error();
    }

    final data = jsonDecode(response.body);
    return data;
  }

  void _handlePress() async {
    try {
      final fetchedData = await _fetchDataFromApi(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata',
      );
      setState(() {
        _fetchedData = fetchedData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_fetchedData',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handlePress,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
