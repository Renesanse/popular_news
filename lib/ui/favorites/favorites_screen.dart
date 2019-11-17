import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card_presenter.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import 'favorites_presenter.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialData = PresenterProvider.of<FavoritesPresenter>(context).initialData;
    final stream = PresenterProvider.of<FavoritesPresenter>(context).stream;
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        TitleAppBar(title: 'Избранное'),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2), () {});
          },
        ),
        StreamBuilder(
          key: ValueKey('favBuilder'),
          stream: stream,
          initialData: initialData,
          builder: (ctx, AsyncSnapshot<List<Article>> snapshot) {
            print('stream builder values is ' + snapshot.data.length.toString());
            return SliverList(
              key: ValueKey('favList'),
              delegate: SliverChildListDelegate(snapshot.data
                  .map((article) => PresenterProvider<Store<AppState>, NewsCardPresenter>(
                      key: ValueKey(article.url + 'fav'),
                      presenter: NewsCardPresenter(article.url),
                      child: NewsCard(
                        article: article,
                        key: ValueKey(article.url + 'fav1'),
                      )))
                  .toList()),
            );
          },
        )
      ],
    );
  }
}