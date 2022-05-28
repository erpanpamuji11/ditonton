import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tvseries/on_the_air_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/pages/home_tvseries_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';


void main() {
  late FakeOnTheAirTvseriesBloc fakeOnTheAirTvseriesBloc;
  late FakePopularTvseriesBloc fakePopularMovieBloc;
  late FakeTopRatedTvseriesBloc fakeTopRatedMovieBloc;

  setUp(() {
    fakeOnTheAirTvseriesBloc = FakeOnTheAirTvseriesBloc();
    registerFallbackValue(FakeOnTheAirTvseriesEvent());
    registerFallbackValue(FakeOnTheAirTvseriesState());

    fakePopularMovieBloc = FakePopularTvseriesBloc();
    registerFallbackValue(FakePopularTvseriesEvent());
    registerFallbackValue(FakePopularTvseriesState());

    fakeTopRatedMovieBloc = FakeTopRatedTvseriesBloc();
    registerFallbackValue(FakeTopRatedTvseriesEvent());
    registerFallbackValue(FakeTopRatedTvseriesState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeOnTheAirTvseriesBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnTheAirTvseriesBloc>(
          create: (context) => fakeOnTheAirTvseriesBloc,
        ),
        BlocProvider<PopularTvseriesBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedTvseriesBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeOnTheAirTvseriesBloc.state)
        .thenReturn(OnTheAirTvseriesLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(PopularTvseriesLoading());
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedTvseriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeTvSeriesPage()));

    expect(circularProgressIndicatorFinder, findsNWidgets(3));
  });

  testWidgets(
      'page should display listview of NowPlayingTvseries when HasData state is happen',
      (WidgetTester tester) async {
    when(() => fakeOnTheAirTvseriesBloc.state)
        .thenReturn(OnTheAirTvseriesHasData(testTvList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularTvseriesHasData(testTvList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedTvseriesHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeTvSeriesPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should display error with text when Error state is happen',
      (WidgetTester tester) async {
    when(() => fakeOnTheAirTvseriesBloc.state)
        .thenReturn(OnTheAirTvseriesError('error'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularTvseriesError('error'));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedTvseriesError('error'));

    final errorKeyFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(const HomeTvSeriesPage()));
    expect(errorKeyFinder, findsNWidgets(3));
  });

  testWidgets('page should not display when Empty state is happen',
      (WidgetTester tester) async {
    when(() => fakeOnTheAirTvseriesBloc.state)
        .thenReturn(OnTheAirTvseriesEmpty());
    when(() => fakePopularMovieBloc.state).thenReturn(PopularTvseriesEmpty());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedTvseriesEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_createTestableWidget(const HomeTvSeriesPage()));
    expect(containerFinder, findsNWidgets(3));
  });
}
