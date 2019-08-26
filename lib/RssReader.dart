import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:xml/xml.dart';

class RssReader {
  //final _targetUrl = 'https://www.becompany.ch/en/blog/feed.xml';
  final _targetUrl = 'https://jnis.bmj.com/rss/current.xml';

  Future<RdfFeed> getFeed(url) =>
      http.read(url).then((xmlString) => RdfFeed.parse(xmlString));
  //Future<RdfFeed> getFeed() {
  //  return http.read(_targetUrl).then((xmlString) {
  //    return RdfFeed.parse(xmlString);
  //  });
  //}
}
