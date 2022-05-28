import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/pages/top_rated_tvseries_page.dart';

import '../../helpers/pages_test_helpers.dart';


void main() {
  late FakeTopRatedTvseriesBloc fakeTopRatedTvseriesBloc;

  setUpAll(() {
    fakeTopRatedTvseriesBloc = FakeTopRatedTvseriesBloc();
    registerFallbackValue(FakeTopRatedTvseriesEvent());
    registerFallbackValue(FakeTopRatedTvseriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvseriesBloc>(
      create: (_) => fakeTopRatedTvseriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeTopRatedTvseriesBloc.close());

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvseriesBloc.state)
        .thenReturn(TopRatedTvseriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });


  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeTopRatedTvseriesBloc.state)
        .thenReturn(TopRatedTvseriesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
