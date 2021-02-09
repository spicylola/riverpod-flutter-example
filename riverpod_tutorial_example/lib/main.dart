import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope( // like provider container that is responsible for holding
    // the state of provider containers
      child: MyApp()));
}

class FakeHttpClient {
  Future<String> get(String url) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Response from $url';
  }
}
final fakeHttpClientProvider = Provider((ref) => FakeHttpClient());
final responseProvider = FutureProvider.family<String, String>((ref, url) async {
  final httpClient = ref.read(fakeHttpClientProvider);
  return httpClient.get(url);
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Tutorial',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        appBar: AppBar(title: Text('Riverpod Tutorial'),),
        body: Center(
          child: Consumer(
            builder: (context,watch, child){
              final responseAsyncValue = watch(responseProvider("google.com"));
              return responseAsyncValue.map(
                  data: (_) => Text(_.value),
                  loading: (_) => CircularProgressIndicator(),
                  error: (_) => Text(_.error.toString(), style: TextStyle(color: Colors.red),)
              );
            }
          ),
        ),
      ),
    );
  }
}

// example riverpod for Increment Provider
// the state of provider is not based on scope but within widget, its being used
final greetingProvider = Provider((ref) => 'Hello  Ms. Riverpod');
final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());

String myGlobalFunction(){
    return 'some value';
  }

  class myClass{
  void _classMethod(){
  final valueLocalToThisMethod = myGlobalFunction();
  }
  }

  class IncrementNotifier extends ChangeNotifier{
      int _value = 0;
      int get value => _value;

      void increment(){
        _value += 1;
        notifyListeners();
      }
  }

class MyIncrementAppExample extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Tutorial',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        appBar: AppBar(title: Text('Riverpod Tutorial'),),
        body: Center(
          child: Consumer(
            builder: (context, watch, child) {
                final incrementNotifier = watch(incrementProvider);
                return Text(incrementNotifier.value.toString());
            }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read(incrementProvider).increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}



class MyConsumerWidgetAppExample extends ConsumerWidget {

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final greeting = watch(greetingProvider);
    return MaterialApp(
      title: 'Riverpod Tutorial',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        appBar: AppBar(title: Text('Riverpod Tutorial'),),
        body: Center(
          child: Text(greeting),
        ),
      ),
    );
  }
}

class PracticeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyFirstClass{
  final value = 'hello';
}

class MySecondClass{
  final MyFirstClass myFirstClass;
  MySecondClass(this.myFirstClass);
}
