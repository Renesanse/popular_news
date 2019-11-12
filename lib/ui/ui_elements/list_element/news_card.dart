import 'dart:core';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/event_enum.dart';
import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';
import 'package:share/share.dart';

class NewsCard extends StatefulWidget {
  final Article article;

  const NewsCard({
    Key key,
    this.article,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  Article get _article => widget.article;

  initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween(begin: 1.0, end: 0.5).animate(controller);
//    Image.network(_article.urlToImage ?? "nothing")
//        .image
//        .resolve(ImageConfiguration())
//        .addListener(ImageStreamListener((imageInfo, synchronousCall) {
//      setState(() {
//        controller.forward();
//      });
//    }));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.key);
    final store = StoreProvider.of(context);
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return Scaffold(
                  appBar: CupertinoNavigationBar(
                    previousPageTitle: "back",
                    transitionBetweenRoutes: false,
                    middle: Text(_article.source.name),
                  ),
//                  body: WebView(
//                    initialUrl: _article.url,
//                  ),
                );
              }));
            },
            child: Container(
              alignment: Alignment.center, //              decoration: BoxDecoration(
//                  image: DecorationImage(
//                      fit: BoxFit.cover,
//                      image: Image.network(
//                        _articleModel.article.urlToImage,
//                        loadingBuilder: (ctx, w, h) => CupertinoActivityIndicator(),
//                      ).image,
//                      colorFilter: ColorFilter.mode(
//                          Colors.transparent.withOpacity(animation.value), BlendMode.srcIn))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16.0, right: 4.0),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(_article.source.name,
                                style: TextStyle(color: CupertinoColors.white))),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(CupertinoIcons.reply, color: Colors.white),
                              onPressed: () async {
                                Share.share(_article.url);
                              },
                            ),
                            StreamBuilder(
                              initialData: StoreProvider.of(context)
                                  .getState<FavoritesState>()
                                  .news
                                  .containsKey(_article.url),
                              stream: StoreProvider.of(context)
                                  .getState<FavoritesState>()
                                  .propertyStream<Map<String, Article>>('news')
                                  .map((news) => news.containsKey(_article.url)),
                              builder: (ctx, AsyncSnapshot<bool> snapshot) {
                                return IconButton(
                                  icon: Icon(
                                      snapshot.data
                                          ? CupertinoIcons.book_solid
                                          : CupertinoIcons.book,
                                      color: Colors.white),
                                  onPressed: () async {
                                    store.dispatchEvent<TopNewsState>(
                                        event: Event.sideEffect(
                                            type: snapshot.data
                                                ? EventType.removeFavorite
                                                : EventType.addFavorite,
                                            bundle: _article.url));
                                  },
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(_article.title,
                        style: TextStyle(color: CupertinoColors.white, fontSize: 20)),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.centerRight,
                    child:
                        Text(_article.publishedAt, style: TextStyle(color: CupertinoColors.white)),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  } //  Animation animation;

}
