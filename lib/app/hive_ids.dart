import 'package:clean_news_ai/app/presentation/navigation/routes.dart';
import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:clean_news_ai/features/news/domain/entities/news_article.dart';
import 'package:clean_news_ai/features/news/domain/entities/news_scope.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:clean_news_ai/features/news/presentation/routes/full_info_route.dart';
import 'package:osam_flutter/osam_flutter.dart';

import 'domain/entities/app_state.dart';

// ignore: camel_case_types
abstract class HiveId {
  //domain
  static const appState = 0;
  static const newsScope = 1;
  static const newsArticle = 2;

  //ui
  static const dialogRoute = 218;
  static const rootRoute = 219;
  static const uiState = 220;
}

void registerAdapters() {
  registerOsamFlutterAdapters();
  Hive.registerAdapter(AppStateAdapter());
  Hive.registerAdapter(NewsScopeAdapter());
  Hive.registerAdapter(NewsArticleAdapter());
  Hive.registerAdapter(RootRouteAdapter());
  Hive.registerAdapter(FullInfoRouteAdapter());
  Hive.registerAdapter(UIStateAdapter());
}
