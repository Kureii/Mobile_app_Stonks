import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'Api.dart';

class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key, required this.coin});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Coin coin;

  @override
  State<MyLineChart> createState() => _MyLineChart();
}


class _MyLineChart extends State<MyLineChart> {


  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\$ ${value.toStringAsFixed(2)}', style: _textStyle),
    );
  }

  double average() {
    double sum = 0;
    for (var element in widget.coin.prices) {
      sum += element.y;
    }
    return sum / widget.coin.prices.length;
  }
  double min() {
    double min = widget.coin.prices.first.y;
    for (var element in widget.coin.prices) {
      if (min > element.y) {
        min = element.y;
      }
    }
    return min;
  }

  double max() {
    double max = widget.coin.prices.first.y;
    for (var element in widget.coin.prices) {
      if (max < element.y) {
        max = element.y;
      }
    }
    return max;
  }

  static const _textStyle = TextStyle(
    //color: Color(0xffffffff),
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  Future<Widget> _icon() async {
    String icon= widget.coin.icon;
    if(icon.isEmpty) {
      return SvgPicture.asset(
        "/lib/icon/noIcon.svg",
        height: 60,
        width: 60,);
    } else {
      List<String> type = icon.split(".");
      if (type.last == "svg" || type.last.split("?").first == "svg") {
        return SvgPicture.network(
          icon,
          width: 60.0,
          height: 60.0,
        );
      } else {
        return Image.network(
          icon,
          width: 60,
          height: 60,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double cutOffYValue = average();

    return DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x55000000),
              offset: Offset(4.0, 4.0),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.coin.color,
            borderRadius: BorderRadius.circular(18),
          ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Row(
                children: [
                  FutureBuilder(
                      future: _icon(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SkeletonLoader(
                            builder: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white10,
                                ),
                              ),
                            ),
                            items: 1,
                            period: const Duration(seconds: 2),
                            highlightColor: Theme.of(context).primaryColor,
                            direction: SkeletonDirection.ltr,
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        String icon= widget.coin.icon;
                        if(icon.isEmpty) {
                          return SvgPicture.asset(
                            "/lib/icon/noIcon.svg",
                            height: 60,
                            width: 60,);
                        } else {
                          List<String> type = icon.split(".");
                          if (type.last == "svg" || type.last.split("?").first == "svg") {
                            return SvgPicture.network(
                              icon,
                              width: 60.0,
                              height: 60.0,
                            );
                          } else {
                            return Image.network(
                              icon,
                              width: 60,
                              height: 60,
                            );
                          }
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${widget.coin.name} – ${widget.coin.symbol}',
                            style: Theme.of(context).textTheme.headline1
                        ),
                        Text(
                          'Aktuální cena: \$${widget.coin.actualPrice}',
                          style: _textStyle,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 1.9,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  //color: Color(0xff232d37),
                ),
                child:
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 12, left: 12, right: 24),
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchSpotThreshold: 10,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: widget.coin.prices,
                          isCurved: true,
                          barWidth: 2,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color.fromARGB(45, 191, 255, 0),
                            cutOffY: cutOffYValue,
                            applyCutOffY: true,
                          ),
                          aboveBarData: BarAreaData(
                            show: true,
                            color: const Color.fromARGB(45, 255, 47, 0),
                            cutOffY: cutOffYValue,
                            applyCutOffY: true,
                          ),
                          dotData: FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                      minY: min() - ((max()-min()) / 10),
                      maxY: max() + ((max()-min()) / 10),
                      borderData: FlBorderData(
                          show: false
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              interval: (max() - min()) / 6,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 80
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: (max() - min()) / 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}