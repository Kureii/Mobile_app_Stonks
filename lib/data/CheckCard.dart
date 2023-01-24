import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'Api.dart';

class CheckCard extends StatefulWidget {
  const CheckCard({super.key, required this.coin});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Coin coin;


  @override
  State<CheckCard> createState() => _CheckCard();
}


class _CheckCard extends State<CheckCard> {


  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\$ ${value.toStringAsFixed(2)}', style: _textStyle),
    );
  }

  static const _textStyle = TextStyle(
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
      if (type.last == "svg" || type.last.split("?").first == "svg"
      ) {
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
    Color isActiveColor;
    if (widget.coin.active){
      isActiveColor = widget.coin.color;
    } else {
      isActiveColor = Theme.of(context).backgroundColor;
    }


    return ElevatedButton(
      onPressed: () => {
        widget.coin.active = !widget.coin.active,
          if (widget.coin.active){
        setState(() {isActiveColor = widget.coin.color;}),
          } else {
        setState(() {isActiveColor = Theme.of(context).backgroundColor;}),
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(18)),
      ),
      child: DecoratedBox(
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
            color: isActiveColor,
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
            ],
          ),
        ),
      ),
    );
  }
}