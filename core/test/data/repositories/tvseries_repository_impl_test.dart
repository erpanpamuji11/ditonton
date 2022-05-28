import 'dart:io';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv_series/tvseries_detail_model.dart';
import 'package:core/data/models/tv_series/tvseries_model.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';
import '../../dummy_data/dummy_objects_tvseries.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,

    );
  });

  const tTvModel = TvSeriesModel(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tTv = TvSeries(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: const [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tTvModelList = <TvSeriesModel>[tTvModel];
  final tTvList = <TvSeries>[tTv];

  group('On The Air Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvSeries())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getOnTheAirTvSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvSeries());
      /* workaround to test List in Right.*/
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTvSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTvSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv', () {
    test('should return Tv list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv', () {
    test('should return Tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Detail', () {
    const tId = 1;
    const tTvResponse = TvSeriesDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      status: 'Status',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      tagline: 'Tagline',
      name: 'name',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(const Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Recommendations', () {
    final tTvList = <TvSeriesModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv', () {
    const tQuery = 'game of thrones';

    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist tv', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return Database Failure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return Database Failure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });


  group('get watchlist tv', () {
    test('should return list of Tv', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
