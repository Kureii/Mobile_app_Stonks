import 'package:apka_s_api/data/CheckCard.dart';
import 'package:apka_s_api/data/save.dart';
import 'package:apka_s_api/main.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'Temporal.dart';
import 'Api.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}


class _Settings extends State<Settings> {

  late List<Coin> graphs;
  List<String> symbols = <String>[];

  bool saveSymbols() {
    symbols = <String>[];
    for(var i = 0; i < graphs.length; ++i)
      {
        if (graphs[i].active) {
          symbols.add(graphs[i].symbol);
        }
      }
    symbols = symbols.toSet().toList();
    if (symbols.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Coin>> _loadData() async {
    var save = MySave();
    var index = 0;
    List<String> loadDataList = ["1h", "3h", "12h", "24h", "7d", "30d", "3m", "1y", "3y", "5y"];
    try {
      index = await save.getIndex();
    } catch (e) {
      index = 4;
    }
    var loadData = loadDataList[index];
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
      case "7y":
        graphs = await temp.getCoins("7y", 10, 0, 0);
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
    Future error() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Musí být vybrána aspoň jedna měna'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    primary:Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Výběr měn"),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Theme.of(context).textTheme.headline1!.color,  ),
          onTap: () async {
            if(saveSymbols()) {
              var save = MySave();
              await save.saveCurrency(symbols);
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: "Stonks")));
            } else {
              error();
            }
          } ,

        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: _loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SkeletonLoader(
                    builder: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child:DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Container (
                              height: 315
                          )
                      ),
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
                  children: List.generate(graphs.length, (counter) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: CheckCard(coin: graphs[counter],)
                  )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}