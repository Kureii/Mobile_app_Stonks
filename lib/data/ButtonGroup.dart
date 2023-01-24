import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  static const double _radius = 14.0;
  static const double _outerPadding = 2.0;

  final int current;
  final List<String> titles;
  final ValueChanged<int> onTab;
  final Color color;
  final Color secondaryColor;

  const ButtonGroup({
    super.key,
    required this.titles,
    required this.onTab,
    current,
    color,
    secondaryColor,
  })  : assert(titles != null),
        current = current ?? 0,
        color = color ?? Colors.blue,
        secondaryColor = secondaryColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 308,
        padding: const EdgeInsets.all(_outerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          color: color,
        ),
        clipBehavior: Clip.antiAlias,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius - _outerPadding),
            child: IntrinsicHeight(
                child: Column(
                  children: _buttonList(),
                )
            ),
          ),
        ),
    );
  }

  List<Widget> _buttonList() {
    var buttons = <Widget>[];
    final rows = <Widget>[];
    for (int i = 0; i < titles.length; i++) {
      buttons.add(_button(titles[i], i));
      buttons.add(
        VerticalDivider(
          width: 1.0,
          color: secondaryColor,
          thickness: 1.5,
          indent: 5.0,
          endIndent: 5.0,
        ),
      );
      if ((i+1) % 5 == 0) {
        buttons.removeLast();
        rows.add(Row(children: buttons,));
        buttons = <Widget>[];
      }
    }
    return rows;
  }

  Widget _button(String title, int index) {
    if (index == this.current)
      return _activeButton(title);
    else
      return _inActiveButton(title, index);
  }

  Widget _activeButton(String title) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      disabledBackgroundColor: secondaryColor,
      disabledForegroundColor: color,
      minimumSize: Size(60, 38),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    child:
    Text(title),
    onPressed: null,
  );

  Widget _inActiveButton(String title, int index) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: color,
      disabledBackgroundColor: Colors.transparent,
      disabledForegroundColor: Colors.white,
      minimumSize: Size(60, 38),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    child: Text(title),
    onPressed: () {
      if (onTab != null) onTab(index);
    },
  );
}