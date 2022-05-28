import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tvseries.dart';
import 'package:core/data/datasources/movies/movie_local_data_source.dart';
import 'package:core/data/datasources/movies/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series/tvseries_local_data_source.dart';
import 'package:core/data/datasources/tv_series/tvseries_remote_data_source.dart';

import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/utils/ssl_helper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecase/get_movie_detail.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';

import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/domain/usecase/search_tvseries.dart';
import 'package:search/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:tv_series/domain/repositories/tvseries_repository.dart';
import 'package:tv_series/domain/usecase/get_now_playing_tvseries.dart';
import 'package:tv_series/domain/usecase/get_popular_tvseries.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tvseries.dart';
import 'package:tv_series/domain/usecase/get_tvseries_detail.dart';
import 'package:tv_series/domain/usecase/get_tvseries_recommendations.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tvseries/on_the_air_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/detail_tvseries/tvseries_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tvseries_recommendations/tvseries_recommendations_bloc.dart';
import 'package:http/io_client.dart';
import 'package:watchlist/domain/usecase/movies/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecase/movies/get_watchlist_status.dart';
import 'package:watchlist/domain/usecase/movies/remove_watchlist.dart';
import 'package:watchlist/domain/usecase/movies/save_watchlist.dart';
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries.dart';
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries_status.dart';
import 'package:watchlist/domain/usecase/tvseries/remove_tvseries_watchlist.dart';
import 'package:watchlist/domain/usecase/tvseries/save_tvseries_watchlist.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient ioClient = await SSLHelper.ioClient;

  // BLoC - Movies
  locator.registerFactory<NowPlayingMovieBloc>(
    () => NowPlayingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // BLoC - TvSeries
  locator.registerFactory(
    () => OnTheAirTvseriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvseriesRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvseriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvseriesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvseriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvseriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvseriesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // Usecase
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Datasource
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTvSeries>(
      () => DatabaseHelperTvSeries());

  // External
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => ioClient);
}
