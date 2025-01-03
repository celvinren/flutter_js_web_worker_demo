import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String calculatedResult = '';
  int n = 40;
  bool switchValue = false;

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
            Switch(
                value: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                }),
            Text(
              'n = $n',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              calculatedResult,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            calculatedResult = 'Loading...';
            n = n < 47 ? n + 1 : 40;
          });

          final result = await compute((int value) {
            return runFibonacci(value);
          }, n);

          setState(() {
            calculatedResult = result.toString();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

/// Run the Fibonacci calculation and return the result
/// n: The number to calculate the Fibonacci sequence for
/// Returns: The result of the Fibonacci calculation
/// Note: This function will block the main thread
int runFibonacci(int n) {
  final stopwatch = Stopwatch()..start();
  int result = fibonacci(n);
  stopwatch.stop();
  print(
      'Fibonacci Calculation finished in ${stopwatch.elapsedMilliseconds} ms');
  print('Result: $result');
  return result;
}
