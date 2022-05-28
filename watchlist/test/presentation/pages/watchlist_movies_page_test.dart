import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
import 'helper/pages_test_helpers.dart';


void main() {
  late FakeWatchlistMovieBloc fakeWatchlistMoviesBloc;

  setUpAll(() {
    fakeWatchlistMoviesBloc = FakeWatchlistMovieBloc();
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>(
      create: (_) => fakeWatchlistMoviesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeWatchlistMoviesBloc.close());

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });


  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
