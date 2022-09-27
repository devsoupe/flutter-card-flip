import 'dart:async';

import 'package:flutter/material.dart';

class SteamScreen extends StatefulWidget {
  const SteamScreen({Key? key}) : super(key: key);

  @override
  State<SteamScreen> createState() => _SteamScreenState();
}

class _SteamScreenState extends State<SteamScreen> {
  int _counter = 0;

  late final StreamController<int> _streamController;

  @override
  void initState() {
    super.initState();

    _streamController = StreamController(onListen: () {
      print('onListen');

      _streamController.add(200);
    });
    // SteamBulder로 감싸면 안써도된다. Build를 제 호출 한다.
    // _streamController.stream.listen((event) {
    //   setState(() {});
    // });

    // _streamController.add(100);
    //
    // StreamSubscription<int> subscription1 = _streamController.stream.listen((event) {
    //   print(event);
    //   setState(() {});
    // });

    // StreamSubscription<int> subscription2 = _streamController.stream.listen((event) {
    //   print('subscription2 $event');
    // });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _incrementCounter() {
    _streamController.add(_counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                print('none');
                break;
              case ConnectionState.active:
                print('active');
                break;
              case ConnectionState.waiting:
                print('waiting');
                break;
              case ConnectionState.done:
                print('done');
                break;
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          }),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon((Icons.add)),
      ),
    );
  }
}
