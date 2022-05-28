import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';

// fake moviw watclist
class FakeWatchlistMovieEvent extends Fake implements WatchlistMoviesEvent {}

class FakeWatchlistMovieState extends Fake implements WatchlistMoviesState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class FakeWatchlistTvSeriesEvent extends Fake implements WatchlistTvseriesEvent {}

class FakeWatchlistTvSeriesState extends Fake implements WatchlistTvseriesState {}

class FakeWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvseriesEvent, WatchlistTvseriesState>
    implements WatchlistTvseriesBloc {}

