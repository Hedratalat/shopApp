abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates{}


class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {
  final List<dynamic> businessArticles; // استخدام List<dynamic> أو نوع البيانات الذي تحتاجه

  NewsGetBusinessSuccessState(this.businessArticles);
}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetTopNewsLoadingState extends NewsStates {}

class NewsGetTopNewsSuccessState extends NewsStates {
  final List<dynamic> TopNews; // استخدام List<dynamic> أو نوع البيانات الذي تحتاجه

  NewsGetTopNewsSuccessState(this.TopNews);
}

class NewsGetTopNewsErrorState extends NewsStates {
  final String error;

  NewsGetTopNewsErrorState(this.error);
}

class AppChangeModeState extends NewsStates {}

class AppInitialStates extends NewsStates{}

class AppChangeBottomNavBarState extends NewsStates{}

class AppCreateDatabaseState extends NewsStates{}

class AppGetDatabaseState  extends NewsStates{}

class AppGetDatabaseLoadingState  extends NewsStates{}


class AppInsertDatabaseState  extends NewsStates{}

class AppUpdateDatabaseState  extends NewsStates{}

class AppDeleteDatabaseState  extends NewsStates{}

