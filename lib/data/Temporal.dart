import 'package:apka_s_api/data/save.dart';
import "dart:convert";
import 'save.dart';
import 'Api.dart';

class Temporal {
  static final Temporal _singleton = Temporal._internal();

  factory Temporal() {
    return _singleton;
  }

  Temporal._internal();




  bool time2Refesh(List<Coin>? period,int periodTimeDays, int periodTimeHours, int periodTimeMinutes,int days,int hours,int minutes) {
    if (period == null){
      return true;
    } else if (period.isEmpty) {
      return true;
    }
    if ((periodTimeMinutes + minutes) <= 60) {
      if((periodTimeHours + hours) <= 24) {
        if((periodTimeMinutes+minutes-60)<=DateTime.now().minute &&
            (periodTimeHours+hours-24)<=DateTime.now().hour &&
            (periodTimeDays+days)< DateTime.now().day){
          return true;
        } else {return false;}
      } else if ((periodTimeMinutes+minutes-60)<=DateTime.now().minute &&
                (periodTimeHours+hours)<DateTime.now().hour ||
                (periodTimeDays+days)< DateTime.now().day) {
        return true;
      }  else {return false;}
    } else if ((periodTimeMinutes+minutes)<DateTime.now().minute ||
        (periodTimeHours+hours)<DateTime.now().hour ||
        (periodTimeDays+days)< DateTime.now().day){
        return true;
    } else {return false;}
  }

  getCoins(String period, int days, int hours, int minutes) async{
    List<Coin>? coins = <Coin>[];
    var save = MySave();
    final api = Api(period);
    List<int> date = await save.getTime(period);
    try {
      String stringJson = await save.getJson(period);
      coins = await api.jsonToCoin(json.decode(stringJson));
    } catch (e){
      coins = <Coin>[];
    }
    if (date[0] != 0 &&date[1] != 0 && date[2] != 0) {
      if (time2Refesh(coins, date[0], date[1], date[2], days, hours, minutes)) {
        coins = await api.GetCoins();
        save.saveTime(period);
      }
    } else {
      coins = await api.GetCoins();
      save.saveTime(period);
    }
    return coins;
  }
}
