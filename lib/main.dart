import 'package:flutter/material.dart';
import 'package:xkcd_demo/Backend.dart';
import 'package:xkcd_demo/ComicCard.dart';
import 'package:xkcd_demo/FullscreenShrinkingSliver.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
  Widget build(BuildContext context) => MaterialApp(
        title: 'XKCD Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          backgroundColor: Colors.white10,
          primaryColor: Colors.purple,
          accentColor: Colors.purple,
        ),
        home: FutureBuilder<List<Comic>>(
            future: Backend.getLatestComics(),
            initialData: null,
            builder: (BuildContext ctx, AsyncSnapshot<List<Comic>> snapshot) =>
                snapshot.hasData
                    ? comicScreen(snapshot.data!, ctx)
                    : loadingScreen()),
      );
}

Widget loadingScreen() => Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

Widget comicScreen(List<Comic> comics, BuildContext ctx) => Scaffold(
      body: CustomScrollView(
        slivers: [
          FullscreenShrinkingSliver(
            child: ComicCard(comics.first),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              comics.skip(1).map((comic) => ComicCard(comic)).toList(),
            ),
          ),
        ],
      ),
    );

