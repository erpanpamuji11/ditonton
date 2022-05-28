import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';


void main() {
  late FakeMovieDetailBloc fakeMovieDetailBloc;
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;
  late FakeMovieRecommendationsBloc fakeMovieRecommendationsBloc;

  setUpAll(() {
    fakeMovieDetailBloc = FakeMovieDetailBloc();
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());

    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();
    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());

    fakeMovieRecommendationsBloc = FakeMovieRecommendationsBloc();
    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => fakeMovieDetailBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => fakeWatchlistMoviesBloc,
        ),
        BlocProvider<MovieRecommendationsBloc>(
          create: (_) => fakeMovieRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeMovieDetailBloc.close();
    fakeWatchlistMoviesBloc.close();
    fakeMovieRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesLoading());
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesHasData(testMovieList));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(testMovieList));
    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: testId)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('movie_detail_content')), findsOneWidget);
  });

  testWidgets(
      'should display add icon when movie is not added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesIsAdded(false));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(testMovieList));
    final addIconFinder = find.byIcon(Icons.add);
    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: testId)));
    await tester.pump();
    expect(addIconFinder, findsOneWidget);
  });

  testWidgets(
      'should display check icon when movie is added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesIsAdded(true));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(testMovieList));
    final checkIconFinder = find.byIcon(Icons.check);
    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: testId)));
    await tester.pump();
    expect(checkIconFinder, findsOneWidget);
  });
}
