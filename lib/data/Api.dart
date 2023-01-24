import "dart:convert";
import 'package:apka_s_api/data/ApiKey.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'save.dart';


class Api {
  final String period;
  Api(this.period);


  Future<String> readJsonFile(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Coin>?> GetCoins() async {
    var url = 'https://api.coinranking.com/v2/coins?timePeriod=$period&x-access-token=${ApiKey().getApiKey}';
    Map<String, dynamic>jsonData = <String, dynamic>{};
    try {
      var save = MySave();
      final response = await http.get(Uri.parse(url));
      jsonData = json.decode(response.body);
      save.saveJson(period, response.body);
      save.saveTime(period);
    } catch (e) {
      return null;
    }

    return jsonToCoin(jsonData);
  }

  jsonToCoin(Map<String, dynamic>jsonData) {
    List<Coin> result = <Coin>[];
    String status = jsonData["status"];
    if (status == "success") {
      var coins = jsonData["data"]["coins"];
      for (var i = 0; i < coins.length; ++i) {

        String symbol = "(bez symbolu)";
        if (coins[i]["symbol"] != null) {
          symbol = coins[i]["symbol"];
        }
        String name = "(bez názvu)";
        if(coins[i]["name"] != null) {
          name = coins[i]["name"];
        }
        String icon = "";
        if (coins[i]["iconUrl"] != null) {
          icon = coins[i]["iconUrl"];
        }
        String color="";
        if(coins[i]["color"] != null) {
          color = coins[i]["color"];
        } else {
          color = "#000000";
        }
        var sparklines = coins[i]["sparkline"];
        double actual = double.parse(coins[i]["price"]);
        List<FlSpot> prices = <FlSpot>[];
        int l = 0;
        for (int j = 0; j < sparklines.length; ++j) {
          if(sparklines[j] != null ) {
            double k = double.parse((j-l).toString());
            prices.add(FlSpot(k, double.parse(sparklines[j])));
          } else {
            ++l;
          }
        }
        Color trueColor = Color(
            int.parse(color.substring(1, 7), radix: 16) + 0x44000000);
        result.add(Coin(symbol, name, icon, trueColor, prices, actual, false));
      }
    } else {
      debugPrint("Error: ${jsonData["error"]}");
    }
    return result;
  }

}




class Coin {
  final String symbol;
  final String name;
  final String icon;
  final Color color;
  final List<FlSpot> prices;
  final double actualPrice;
  bool active;

  Coin(this.symbol, this.name, this.icon, this.color, this.prices, this.actualPrice, this.active);
}
