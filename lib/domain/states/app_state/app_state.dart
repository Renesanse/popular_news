
import 'package:clean_news_ai/domain/states/app_state/settings_state/settings_state.dart';
import 'package:clean_news_ai/domain/states/app_state/top_news_state/top_news_state.dart';
import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

import 'favorites_state/favorites_state.dart';
import 'navigation_state/navigation_state.dart';

part 'app_state.g.dart';

@HiveType()
// ignore: must_be_immutable
class AppState extends BaseState<AppState> {
  @HiveField(0)
  var topNewsState = TopNewsState();
  @HiveField(1)
  var navigationState = NavigationState();
  @HiveField(2)
  var favoritesState = FavoritesState();
  @HiveField(3)
  var settingsState = SettingsState();

  @override
  List<Object> get props => [topNewsState, navigationState, favoritesState, settingsState];
}
