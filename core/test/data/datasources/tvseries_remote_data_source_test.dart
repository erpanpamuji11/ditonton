import 'dart:convert';
import 'package:core/data/datasources/tv_series/tvseries_remote_data_source.dart';
import 'package:core/data/models/tv_series/tvseries_detail_model.dart';
import 'package:core/data/models/tv_series/tvseries_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSourcetv;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSourcetv = TvSeriesRemoteDataSourceImpl(ioClient: mockIOClient);
  });

  group('get Now Playing Tvseries', () {
    final tTvList = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/on_the_air.json')))
        .tvSeriesList;

    test('should return list of Tvseries Model when the response code is 200',
            () async {
          // arrange
          when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
          // act
          final result = await dataSourcetv.getOnTheAirTvSeries();
          // assert
          expect(result, equals(tTvList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourcetv.getOnTheAirTvSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular tvseries', () {
    final tTvList =
        TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/popular_tvseries.json')))
            .tvSeriesList;

    test('should return list of tv when response is success (200)',
            () async {
          // arrange
          when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tvseries.json'), 200));
          // act
          final result = await dataSourcetv.getPopularTvSeries();
          // assert
          expect(result, tTvList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourcetv.getPopularTvSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated tvseries', () {
    final tTvList = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_tvseries.json')))
        .tvSeriesList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated_tvseries.json'), 200));
      // act
      final result = await dataSourcetv.getTopRatedTvSeries();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourcetv.getTopRatedTvSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tvseries detail', () {
    const tId = 1;
    final tTvDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/detail_tvseries.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/detail_tvseries.json'), 200));
      // act
      final result = await dataSourcetv.getTvSeriesDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourcetv.getTvSeriesDetail(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tvseries recommendations', () {
    final tTvList = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tvseries_recommendations.json')))
        .tvSeriesList;
    const tId = 1;

    test('should return list of Tv Model when the response code is 200',
            () async {
          // arrange
          when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries_recommendations.json'), 200));
          // act
          final result = await dataSourcetv.getTvSeriesRecommendations(tId);
          // assert
          expect(result, equals(tTvList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourcetv.getTvSeriesRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search tvseries', () {
    final tSearchResult = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/search_got_tvseries.json')))
        .tvSeriesList;
    const tQuery = 'Spiderman';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockIOClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_got_tvseries.json'), 200));
      // act
      final result = await dataSourcetv.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourcetv.searchTvSeries(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
