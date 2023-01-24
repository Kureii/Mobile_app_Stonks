import 'package:apka_s_api/data/save.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/Temporal.dart';
import 'data/Settings.dart';
import 'data/Graphs.dart';
import 'data/Api.dart';
import 'data/About.dart';
import 'data/ButtonGroup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stonks',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryTextTheme: TextTheme(
            bodyText1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
            bodyText2: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
            headline1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black)),
        textTheme: TextTheme(
            bodyText1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
            bodyText2: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
            headline1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black)),
        backgroundColor: const Color(0xffffffff),
        primaryColor: const Color(0xff91c504),
        cardTheme: const CardTheme(color: Color(0x6691c504)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryTextTheme: TextTheme(
            bodyText1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
            bodyText2: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
            headline1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white)),
        textTheme: TextTheme(
            bodyText1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
            bodyText2: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
            headline1: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white)),
        backgroundColor: const Color(0xff303030),
        primaryColor: const Color(0xff91c504),
        cardTheme: const CardTheme(color: Color(0x6691c504)),
      ),
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      home: const MyHomePage(title: 'Stonks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String loadData = "7d" ;
  late int index;
  late List<Coin> graphs;
  List<String> symbols = ["BTC", "ETH", "DOGE", "SOL", "MATIC"];
  List<String> loadDataList = ["1h", "3h", "12h", "24h", "7d", "30d", "3m", "1y", "3y", "5y"];

  Future<void> _loadIndex() async {
    var save = MySave();
    try {
      index = await save.getIndex();
    } catch (e) {
      index = 4;
    }
}

  Future<List<Coin>> _loadData() async {
    var save = MySave();
    try {
      index = await save.getIndex();
    } catch (e) {
      index = 4;
    }
    loadData = loadDataList[index];
    var temp = Temporal();
    try {
      symbols = await save.getCurrency();
    } catch (e) {
      symbols = ["BTC", "ETH", "DOGE", "SOL", "MATIC"];
    }
    switch (loadData) {
      case "1h":
        graphs = await temp.getCoins("1h", 0, 0, 30);
        break;
      case "3h":
        graphs = await temp.getCoins("3h", 0, 0, 45);
        break;
      case "12h":
        graphs = await temp.getCoins("12h", 0, 1, 0);
        break;
      case "24h":
        graphs = await temp.getCoins("24h", 0, 1, 30);
        break;
      case "7d":
        graphs = await temp.getCoins("7d", 0, 3, 0);
        break;
      case "30d":
        graphs = await temp.getCoins("30d", 0, 5, 0);
        break;
      case "3m":
        graphs = await temp.getCoins("3m", 1, 0, 0);
        break;
      case "1y":
        graphs = await temp.getCoins("1y", 3, 0, 0);
        break;
      case "3y":
        graphs = await temp.getCoins("3y", 6, 0, 0);
        break;
      case "5y":
        graphs = await temp.getCoins("5y", 10, 0, 0);
        break;
      default:
        graphs = await temp.getCoins("7d", 0, 3, 0);
    }
    for (int i = 0; i < graphs.length; ++i) {
      if (symbols.contains(graphs[i].symbol)) {
        graphs[i].active = true;
      } else {
        graphs[i].active = false;
      }
    }
    return graphs;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == '1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              } else if (value == '2') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: '1',
                  child: Text('Měny'),
                ),
                const PopupMenuItem<String>(
                  value: '2',
                  child: Text('O aplikaci'),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container( height: 10,),
            FutureBuilder(
              future: _loadIndex(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SkeletonLoader(
                    builder: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 308,
                          height: 100,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white10,
                          ),
                        ),
                    ),
                    items: 1,
                    period: Duration(seconds: 2),
                    highlightColor: Theme.of(context).primaryColor,
                    direction: SkeletonDirection.ltr,
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return ButtonGroup(
                    titles: loadDataList,
                    current: index,
                    color: Theme.of(context).primaryColor,
                    secondaryColor: Theme.of(context).textTheme.bodyText1?.color,
                    onTab: (selected) async {
                      var save = MySave();
                      save.saveIndex(selected);
                      setState(() {
                        index = selected;
                      });
                    },
                  );
                  }),
            Container( height: 10,),
            FutureBuilder(
              future: _loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SkeletonLoader(
                    builder: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Container(height: 315)),
                    ),
                    items: 10,
                    period: Duration(seconds: 2),
                    highlightColor: Theme.of(context).primaryColor,
                    direction: SkeletonDirection.ltr,
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Column(
                  children: List.generate(graphs.length, (int index) {
                    if (graphs[index].active) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          child: MyLineChart(coin: graphs[index]));
                    } else {
                      return Container();
                    }
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
