import 'package:about/about_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/ssl_helper.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:search/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:search/presentation/pages/search_page_tvseries.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tvseries/on_the_air_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/detail_tvseries/tvseries_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tvseries_recommendations/tvseries_recommendations_bloc.dart';
import 'package:tv_series/presentation/pages/home_tvseries_page.dart';
import 'package:tv_series/presentation/pages/popular_tvseries_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tvseries_page.dart';
import 'package:tv_series/presentation/pages/tvseries_detail_page.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SSLHelper.init();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvseriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case HomeTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const HomeTvSeriesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedTvSeriesPage());
            case SearchPageTvSeries.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const SearchPageTvSeries());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );

            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
