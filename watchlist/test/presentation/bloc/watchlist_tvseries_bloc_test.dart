import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries.dart';
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries_status.dart';
import 'package:watchlist/domain/usecase/tvseries/remove_tvseries_watchlist.dart';
import 'package:watchlist/domain/usecase/tvseries/save_tvseries_watchlist.dart';
import 'package:watchlist/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../dummy_data/dummy_objects_tvseries.dart';
import 'watchlist_tvseries_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTvSeries,
  GetWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  SaveWatchlistTvSeries
])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late WatchlistTvseriesBloc watchlistTvseriesBloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    watchlistTvseriesBloc = WatchlistTvseriesBloc(
      mockGetWatchlistTvSeries,
      mockGetWatchListStatusTvSeries,
      mockRemoveWatchlistTvSeries,
      mockSaveWatchlistTvSeries,
    );
  });

  test('the WatchlisttvSeriesEmpty initial state should be empty ', () {
    expect(watchlistTvseriesBloc.state, WatchlistTvseriesEmpty());
  });

  group('get watchlist movies test cases', () {
    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should emits WatchlistMovieLoading state and then WatchlistMovieHasData state when data is successfully fetched..',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTvSeries]));
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvseriesCalled()),
      expect: () => [
        WatchlistTvseriesLoading(),
        WatchlistTvseriesHasData([testWatchlistTvSeries]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
        return OnWatchlistTvseriesCalled().props;
      },
    );

    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesError state when data is failed fetched..',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvseriesCalled()),
      expect: () => <WatchlistTvseriesState>[
        WatchlistTvseriesLoading(),
        WatchlistTvseriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvseriesLoading(),
    );

    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesEmpty state when data is retrieved empty..',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvseriesCalled()),
      expect: () => <WatchlistTvseriesState>[
        WatchlistTvseriesLoading(),
        WatchlistTvseriesEmpty(),
      ],
    );
  });

  group('get watchlist status movies test cases', () {
    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should be return true when the watchlist is also true',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
      expect: () => [WatchlistTvseriesIsAdded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusTvSeries.execute(testMovieDetail.id));
        return FetchWatchlistStatus(testMovieDetail.id).props;
      },
    );

    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
        'should be return false when the watchlist is also false',
        build: () {
          when(mockGetWatchListStatusTvSeries.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistTvseriesBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
        expect: () => <WatchlistTvseriesState>[
          WatchlistTvseriesIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatusTvSeries.execute(testMovieDetail.id));
          return FetchWatchlistStatus(testMovieDetail.id).props;
        });
  });

  group('add watchlist test cases', () {
    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should update watchlist status when adding movie to watchlist is successfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(AddTvseriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvseriesMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        return AddTvseriesToWatchlist(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should throw failure message status when adding movie to watchlist is failed',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
                (_) async => Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(AddTvseriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvseriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        return AddTvseriesToWatchlist(testTvSeriesDetail).props;
      },
    );
  });

  group('remove watchlist test cases', () {
    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should update watchlist status when removing movie from watchlist is successfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(RemoveTvseriesFromWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvseriesMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        return RemoveTvseriesFromWatchlist(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
      'should throw failure message status when removie movie from watchlist is failed',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
                (_) async => Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvseriesBloc;
      },
      act: (bloc) => bloc.add(RemoveTvseriesFromWatchlist(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvseriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        return RemoveTvseriesFromWatchlist(testTvSeriesDetail).props;
      },
    );
  });
}
