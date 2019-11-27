import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tab_bar/model/User.dart';
import 'package:tab_bar/page/login.dart';
import 'package:tab_bar/page/welcome.dart';
import 'package:fluro/fluro.dart';

import 'model/Counter.dart';
import 'router/application.dart';
import 'router/routes.dart';

SelectView(IconData icon, String text, String id) {
  return PopupMenuItem<String>(
    value: id,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.blue,
        ),
        Text(text),
      ],
    ),
  );
}

void main() {
  //错误搜集
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      //重定向到外层的报错,有外层的报错处理
      Zone.current.handleUncaughtError(details.exception, details.stack);
      //错误的时候输出的内容
      return Container(color: Colors.transparent);
    };
    runApp(
      MultiProvider(
        providers: [
          //Provider.value(value: textSize),
          ChangeNotifierProvider<User>.value(value: User("na")),
          ChangeNotifierProvider<Counter>.value(value: Counter(1))
        ],
        child: MaterialApp(
          theme: ThemeData(
            accentColor :Colors.blue,
           // brightness: Brightness.dark,
            accentColorBrightness: Brightness.dark,
            primaryColorBrightness: Brightness.light,
            primaryColor: Colors.red,
          ),
          routes: {
            '/': (BuildContext context) {
              return Welcome();
            },
            '/home': (BuildContext context) {
              return MyApp();
            },
            '/login': (BuildContext context) {
              return LoginComponent();
            },
          },
          //home: MyApp(),
        ),
      ),
    );
    // runApp(AppComponent());
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

/* class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Fluro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Application.router.generator,
    );
//    print("initial route = ${app.initialRoute}");
    return app;
  }
} */

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final user = User("name");
  @override
  Widget build(BuildContext context) {
    print('rebuild page 1');
    return Consumer<User>(
      builder: (context, val, ild) => Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              child: Text("下一页"),
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondPage();
                }))
              },
            ),
            IconButton(
              icon: Icon(Icons.swap_horizontal_circle),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            PopupMenuButton<String>(
              itemBuilder: (context) => <PopupMenuItem<String>>[
                SelectView(Icons.message, "发起群聊", 'A'),
                SelectView(Icons.group_add, "添加", 'B'),
                SelectView(Icons.cast_connected, "扫一扫", 'C'),
              ],
            )
          ],
          title: Text("Flutter Demo"),
          brightness: Brightness.dark,
          centerTitle: true,
        ),
        body: Center(
          child: Text("${val.name}+${Provider.of<Counter>(context).count}"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: Provider.of<Counter>(context).count,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), title: Text('Business')),
            BottomNavigationBarItem(
                icon: Icon(Icons.school), title: Text('School')),
          ],
          onTap: (index) {
            Provider.of<Counter>(context).setCount(index);
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Provider.of<Counter>(context).add();
        }),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider(
      builder: (_) => Counter,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Consumer<Counter>(
        builder: (context, Counter counter, _) => Center(
          child: _,
        ),
        child: Text("0"),
      ),
      floatingActionButton: Consumer<Counter>(
        builder: (context, Counter counter, Widget child) =>
            FloatingActionButton(
          tooltip: "${counter.count}",
          onPressed: counter.add,
          child: child,
        ),
        child: Text("000"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer<Counter>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$value',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}

/* class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
} */
