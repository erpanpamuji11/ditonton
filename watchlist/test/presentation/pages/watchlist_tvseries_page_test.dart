import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_tvseries_page.dart';
import 'helper/pages_test_helpers.dart';


void main() {
  late FakeWatchlistTvSeriesBloc fakeWatchlistTvseriesBloc;

  setUpAll(() {
    fakeWatchlistTvseriesBloc = FakeWatchlistTvSeriesBloc();
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvseriesBloc>(
      create: (_) => fakeWatchlistTvseriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeWatchlistTvseriesBloc.close());

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvseriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvseriesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
