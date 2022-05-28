import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';

// fake now playing movies bloc
class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMovieEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMovieState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState>
    implements NowPlayingMovieBloc {}

// fake popular movies bloc
class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

// fake top rated movies bloc
class FakeTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

// fake detail movie bloc
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

// fake movie recommendations bloc
class FakeMovieRecommendationsEvent extends Fake
    implements MovieRecommendationsEvent {}

class FakeMovieRecommendationsState extends Fake
    implements MovieRecommendationsState {}

class FakeMovieRecommendationsBloc
    extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

// fake watchlist movies bloc
class FakeWatchlistMoviesEvent extends Fake implements WatchlistMoviesEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

class FakeWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}
