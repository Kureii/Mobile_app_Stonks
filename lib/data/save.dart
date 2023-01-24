import 'package:shared_preferences/shared_preferences.dart';

class MySave {
  static final MySave _singleton = MySave._internal();
  late dynamic prefs;

  factory MySave() {
    return _singleton;
  }

  MySave._internal() {
    _save();
  }
  _save() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveTime(period) async{
    prefs = await SharedPreferences.getInstance();
    String timeStamp = "${DateTime.now().day}.";
    timeStamp += "${DateTime.now().hour}.";
    timeStamp += DateTime.now().minute.toString();
    await prefs.setString("${period}Time", timeStamp);
  }

  saveJson(String period, String json) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(period, json);
  }

  saveCurrency(List<String> symbols) async{
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('items') ;
    await prefs.setStringList('items', symbols);
  }

  saveIndex(int index) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt("index", index);
  }

  Future<List<int>> getTime(period) async {
    prefs = await SharedPreferences.getInstance();
    String? date = await prefs.getString("${period}Time");
    if (date != null) {
      List<String> listDate = date.split(".");
      return [int.parse(listDate[0]),
        int.parse(listDate[1]),
        int.parse(listDate[2])];
    } else {
      return <int>[0,0,0];
    }
  }

  Future<List<String>> getCurrency() async {
    prefs = await SharedPreferences.getInstance();
    return await  prefs.getStringList('items');
  }

  Future<String> getJson(period) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs.getString(period);
  }

  Future<int> getIndex() async {
    prefs = await SharedPreferences.getInstance();
    return await prefs.getInt("index");
  }
}