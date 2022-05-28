import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tvseries_page.dart';

import '../../helpers/pages_test_helpers.dart';


void main() {
  late FakePopularTvseriesBloc fakePopularTvseriesBloc;

  setUpAll(() {
    fakePopularTvseriesBloc = FakePopularTvseriesBloc();
    registerFallbackValue(FakePopularTvseriesEvent());
    registerFallbackValue(FakePopularTvseriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvseriesBloc>(
      create: (_) => fakePopularTvseriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() {
    fakePopularTvseriesBloc.close();
  });

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTvseriesBloc.state)
        .thenReturn(PopularTvseriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });


  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakePopularTvseriesBloc.state)
        .thenReturn(PopularTvseriesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
