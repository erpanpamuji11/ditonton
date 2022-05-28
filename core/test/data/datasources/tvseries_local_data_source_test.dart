import 'package:core/data/datasources/tv_series/tvseries_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tvseries.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late TvSeriesLocalDataSourceImpl tvSeriesLocalDataSourceImpl;
  late MockDatabaseHelperTvSeries mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelperTv = MockDatabaseHelperTvSeries();
    tvSeriesLocalDataSourceImpl = TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelperTv);
  });

  group('save watchlist tvseries', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await tvSeriesLocalDataSourceImpl.insertWatchlistTvSeries(testTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist tvseries');
    });

    test('should throw DatabaseException when insert tv_series to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = tvSeriesLocalDataSourceImpl.insertWatchlistTvSeries(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist tvseries', () {

    test('should throw DatabaseException when remove tv_series from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = tvSeriesLocalDataSourceImpl.removeWatchlistTvSeries(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tvseries Detail By Id', () {
    const tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesMap);
      // act
      final result = await tvSeriesLocalDataSourceImpl.getMovieByIdTvSeries(tId);
      // assert
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await tvSeriesLocalDataSourceImpl.getMovieByIdTvSeries(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tvseries', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelperTv.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await tvSeriesLocalDataSourceImpl.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesTable]);
    });
  });
}
