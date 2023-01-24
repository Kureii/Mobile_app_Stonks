import 'package:flutter/material.dart';
import '../main.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _About();
}

class _About extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Výběr měn"),
        leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                      child: Column(children: [
                        Text("Police",
                            style: Theme.of(context).textTheme.headline1),
                        RichText(
                          text: const TextSpan(
                              text:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Velit laoreet id donec ultrices tincidunt arcu non sodales. Vitae auctor eu augue ut lectus arcu bibendum at. Vel quam elementum pulvinar etiam non quam. Lobortis elementum nibh tellus molestie nunc. Sodales neque sodales ut etiam sit amet nisl. Lacus vestibulum sed arcu non. Adipiscing bibendum est ultricies integer quis. Mauris vitae ultricies leo integer. Venenatis tellus in metus vulputate. Montes nascetur ridiculus mus mauris vitae. Egestas congue quisque egestas diam in arcu. Aliquam sem fringilla ut morbi. Magna ac placerat vestibulum lectus mauris ultrices eros. Semper auctor neque vitae tempus quam pellentesque. Elementum eu facilisis sed odio morbi quis.'),
                        ),
                      ])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(children: [
                        Text("Teacher",
                            style: Theme.of(context).textTheme.headline1),
                        RichText(
                          text: const TextSpan(
                              text:
                                  'Lacus vestibulum sed arcu non odio euismod lacinia. Molestie a iaculis at erat. Nunc consequat interdum varius sit amet. Lacinia quis vel eros donec ac odio tempor orci. Diam vel quam elementum pulvinar etiam. Sed odio morbi quis commodo odio aenean sed adipiscing. Molestie ac feugiat sed lectus vestibulum. Molestie nunc non blandit massa enim nec dui nunc mattis. Dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Porta nibh venenatis cras sed. Scelerisque purus semper eget duis at tellus at. Bibendum est ultricies integer quis auctor elit sed vulputate.'),
                        ),
                      ])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(children: [
                        Text("Pie",
                            style: Theme.of(context).textTheme.headline1),
                        RichText(
                          text: const TextSpan(
                              text:
                                  'Ut morbi tincidunt augue interdum velit. Massa ultricies mi quis hendrerit dolor magna eget. Etiam dignissim diam quis enim lobortis scelerisque fermentum. Rhoncus mattis rhoncus urna neque viverra justo. Risus sed vulputate odio ut enim. Curabitur vitae nunc sed velit dignissim sodales ut. Tempor commodo ullamcorper a lacus vestibulum sed arcu non odio. Vulputate eu scelerisque felis imperdiet proin fermentum. Enim diam vulputate ut pharetra. Duis at tellus at urna. Lectus proin nibh nisl condimentum id venenatis a condimentum. Viverra nam libero justo laoreet.'),
                        ),
                      ])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Column(children: [
                      Text("Inspection",
                          style: Theme.of(context).textTheme.headline1),
                      RichText(
                        text: const TextSpan(
                            text:
                                'Nunc congue nisi vitae suscipit tellus mauris a. Leo integer malesuada nunc vel risus commodo viverra maecenas. Egestas erat imperdiet sed euismod. Nisi porta lorem mollis aliquam ut porttitor leo. Lobortis mattis aliquam faucibus purus in massa tempor. Amet cursus sit amet dictum sit amet. Nibh venenatis cras sed felis eget velit aliquet sagittis. Vitae nunc sed velit dignissim sodales ut eu sem. Sollicitudin nibh sit amet commodo nulla. Fermentum dui faucibus in ornare quam viverra orci sagittis. Semper eget duis at tellus. Magna fermentum iaculis eu non diam phasellus. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra orci.'),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(
                        children: [
                          Text("Mood",
                              style: Theme.of(context).textTheme.headline1),
                          RichText(
                            text: const TextSpan(
                                text:
                                    'Accumsan sit amet nulla facilisi morbi tempus iaculis urna id. Odio ut enim blandit volutpat maecenas. Vel pretium lectus quam id. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Nec nam aliquam sem et tortor. Nibh praesent tristique magna sit amet purus gravida quis. Netus et malesuada fames ac. Non pulvinar neque laoreet suspendisse interdum. Lorem mollis aliquam ut porttitor leo a diam sollicitudin tempor. Fames ac turpis egestas sed.'),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
