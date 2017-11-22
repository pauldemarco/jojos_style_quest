import 'package:flutter/material.dart';
import 'package:hello/blog_home.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
        accentColor: Colors.cyanAccent,
        fontFamily: 'Cinzel'
      ),
      home: new MyHomePage(title: 'Jojos Style Quest for Less'),
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
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _controller;
  int _counter = 0;
  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();
    _controller = new PageController(initialPage: 0, keepPage: false, viewportFraction: 2.0);
  }

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
  
  void handleTap(int page) {
    //_controller.animateToPage(page, duration: const Duration(seconds: 1), curve: Curves.ease);
    onPageChanged(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
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
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title, style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold),),
      ),
//    body: new BlogHome(),
      body: new IndexedStack(
        //physics: const NeverScrollableScrollPhysics(),
        //onPageChanged: onPageChanged,
        children: <Widget>[
          new BlogHome(),
          new Center(child: new Text('About'),),
          new Center(child: new Text('Contact'),),
        ],
        //controller: _controller,

        index: _currentIndex,
      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text('Home')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.info), title: new Text('About')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.email), title: new Text('Contact')),
        ],
        onTap: (i) => handleTap(i),
        currentIndex: _currentIndex,
      ),
    );
  }
}

launchURL(String url, {bool forceWebView: false}) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: forceWebView);
  } else {
    throw 'Could not launch $url';
  }
}