import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyHomePage(isLoading: false, counter: 0, child: MyCenterWidget()),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final bool isLoading;
  final int counter;
  final Widget child;

  const MyHomePage({
    required this.isLoading,
    required this.counter,
    required this.child,
  });

  @override
  State<MyHomePage> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  late bool _isLoading;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild MyHomePage');
    return Scaffold(
      body: MyInheritedWidget(
        isLoading: _isLoading,
        counter: _counter,
        child: widget.child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFloatingButtonClicked,
      ),
    );
  }

  void onFloatingButtonClicked() {
    print('Button clicked!. Call setState method');
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild CounterWidget');
    final myInheritedWidget = MyInheritedWidget.of(context);

    if (myInheritedWidget == null) {
      return Text('MyInheritedWidget was not found');
    }

    return myInheritedWidget.isLoading
        ? CircularProgressIndicator()
        : Text('${myInheritedWidget.counter}');
  }
}

class MyCenterWidget extends StatelessWidget {
  int father = 0;
  @override
  Widget build(BuildContext context) {
    print('rebuild MyCenterWidget');
    return Center(
      child: CounterWidget(),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final int counter;
  final bool isLoading;
  @override
  final Widget child;

  MyInheritedWidget({
    required this.isLoading,
    required this.counter,
    required this.child,
  }) : super(child: child);

  @override
  // Check update Inherit widget
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return isLoading != oldWidget.isLoading || counter != oldWidget.counter;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
