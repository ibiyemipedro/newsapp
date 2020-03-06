import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  static String tag = 'Dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

final Color themeColor = Colors.deepOrangeAccent;
final Color otherColor = Colors.blueGrey;
double screenWidth, screenHeight;

final Color backgroundColor = Colors.white;
final textheadsize = 18.0;
final amountsize = 35.0;
final textbodysize = 17.0;
final menutextsize = 17.0;
final textbodysizesm = 14.0;
final textloadingsize = 10.0;
final Color textColor = Colors.white;
final tabFontSize = 10.0;
final double imgHeight = 40;
final fontFam = '';

class _DashboardState extends State<Dashboard> {
  final String apiKey = 'b6cec8dfb0fb4717b3b57eec1096760c';

  Future<List<NewsArticles>> fetchDashboard() async {
    var webAddress =
        "http://newsapi.org/v2/top-headlines?country=us&apiKey=" + apiKey;
    var response = await http.get(Uri.encodeFull(webAddress));
    var res = jsonDecode(response.body);
    var newsdata = res['articles'];

    List<NewsArticles> news = [];

    for (var u in newsdata) {
      NewsArticles message = NewsArticles(u["author"], u["title"],
          u["description"], u["urlToImage"], u["content"]);
      news.add(message);
    }
    return news;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    final newsCont = Container(
      child: FutureBuilder(
        future: fetchDashboard(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.data.length < 1) {
              return Container(
                child: Center(
                  child: AutoSizeText(
                    'No News Articles',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else {
              return Container(
                height: screenHeight * 0.5,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Container(
                          height: 0.5 * screenHeight,
                          width: 0.1 * screenWidth,
                          child:
                              Image.network(snapshot.data[index].urlToImage)),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].description),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    NewsArticlesDetails(snapshot.data[index])));
                      },
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: themeColor,
              child: Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Bong News',
                        style: TextStyle(fontSize: amountsize, color: backgroundColor),
                      ),
                      SizedBox(height: 5.0)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: AutoSizeText(
                      'Find the latest breaking news and information on the top stories, weather, business, entertainment, politics, and more',
                      style: TextStyle(fontSize: textbodysize),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: AutoSizeText(
                      'Latest News',
                      style:
                          TextStyle(fontSize: menutextsize, color: themeColor),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  newsCont,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsArticles {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String content;

  NewsArticles(
      this.author, this.title, this.description, this.urlToImage, this.content);
}

class NewsArticlesDetails extends StatelessWidget {
  final NewsArticles message;
  NewsArticlesDetails(this.message);
  @override
  Widget build(BuildContext context) {
    if (message.author == null || message.title == null || message.urlToImage == null || message.content == null){
      return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(message.title),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                // height: 150.0,
                child: Image.network(
                  message.urlToImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 10.0),
              AutoSizeText(
                message.title ,
                style: TextStyle(fontSize: textheadsize, color: otherColor),
              ),
              SizedBox(height: 15.0),
              AutoSizeText( message.description,
                style: TextStyle(fontSize: textheadsize),),
              SizedBox(height: 30.0),
             
            ],
          ),
        ),
      ),
    );

    }else{

      return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(message.title),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                // height: 150.0,
                child: Image.network(
                  message.urlToImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 10.0),
              AutoSizeText(
                message.title + ' written by ' + message.author,
                style: TextStyle(fontSize: textheadsize, color: otherColor),
              ),
              SizedBox(height: 15.0),
              AutoSizeText(
                message.description,
                style: TextStyle(fontSize: textheadsize),
              ),
              SizedBox(height: 30.0),
              AutoSizeText(
                message.content,
                style: TextStyle(fontSize: textbodysize),
              ),
            ],
          ),
        ),
      ),
    );

    }
    
  }
}
