import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jnis_mobile_app/RssReader.dart';
import 'package:jnis_mobile_app/webview_container.dart';
import 'package:url_launcher/url_launcher.dart';

class MainAppScreen extends StatefulWidget {
  MainAppScreen({Key key, this.title, this.url}) : super(key: key);

  final String title;
  final String url;

  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  var feed;

  @override
  void initState() {
    RssReader().getFeed(widget.url).then((response) {
      setState(() => feed = response);
    });
  }

  _launchURL(url) async {
    //const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch url'); //Should replace with error to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (feed == null) {
            return Align(
              alignment: Alignment.center,
              child: Text("Please Wait"),
            );
          } else {
            return ListView.builder(
              itemCount: feed.items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                final item = feed.items[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ExpansionTile(
                    title: Text(item.title),
                    children: <Widget>[
                      Text('Published online at ' +
                          DateFormat.yMd()
                              .format(DateTime.parse(item.dc.date))),
                      Text('Authors: ' + item.dc.creator),
                      Text(item.description),
                      RaisedButton(
                        child: Text("Go to article online"),
                        onPressed: () {
                          _launchURL(item.link);
                        },
                      ),
                    ],
                    //subtitle: Text('Published online at ' +
                    //    DateFormat.yMd()
                    //        .format(DateTime.parse(item.dc.date))),
                    //contentPadding: EdgeInsets.all(16.0),
                    //onTap: () async {
                    //  //Navigator.push(
                    //  //    context,
                    //  //    MaterialPageRoute(
                    //  //        builder: (context) => WebViewContainer(item
                    //  //            .link
                    //  //            .replaceFirst('http', 'https'))));
                    //},
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
