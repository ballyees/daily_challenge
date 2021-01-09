import 'package:daily_challenge/src/Logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider with ChangeNotifier {
  int counter = 0;

  static final CounterProvider _instance = CounterProvider._internal();

  factory CounterProvider() {
    CustomLogger.log('counter provider: singleton factory');
    return _instance;
  }

  CounterProvider._internal() {
    counter = 0;
    CustomLogger.log('counter provider: singleton created');
  }

  void increment() {
    counter++;
    notifyListeners();
  }
}

class CounterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("counter page state created !!!");

    CounterProvider counterProvider = Provider.of<CounterProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          Consumer<CounterProvider>(
              builder: (context, data, child) =>
                  buildText(context, counterProvider.counter)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  buildText(context, value) {
    print("Text value: $value");
    return Text(
      '$value',
      style: Theme.of(context).textTheme.display1,
    );
  }
}

