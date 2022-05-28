import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv_series/tvseries_detail_model.dart';
import 'package:core/data/models/tv_series/tvseries_model.dart';
import 'package:core/data/models/tv_series/tvseries_response.dart';
import 'package:core/data/models/tv_series/tvseries_table.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';


const testTvSeriesModel = TvSeriesModel(
  backdropPath: "/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg",
  firstAirDate: "2019-06-16",
  genreIds: [18],
  id: 85552,
  name: "Euphoria",
  originalName: "Euphoria",
  overview:
      "A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.",
  popularity: 4532.872,
  posterPath: "/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg",
  voteAverage: 8.4,
  voteCount: 5986,
);

final testTvSeriesModelList = <TvSeriesModel>[testTvSeriesModel];

final testTvSeries = testTvSeriesModel.toEntity();

final testTvList = <TvSeries>[testTvSeries];

final testTvSeriesResponse =
    TvSeriesResponse(tvSeriesList: testTvSeriesModelList);

const testTvSeriesDetailResponse = TvSeriesDetailResponse(
  backdropPath: '',
  firstAirDate: '',
  genres: [GenreModel(id: 1, name: 'Comedy')],
  homepage: '',
  id: 1,
  name: 'name',
  numberOfEpisodes: 0,
  numberOfSeasons: 0,
  originalLanguage: 'en',
  originalName: 'W*A*L*T*E*R',
  overview: "overview",
  popularity: 2.165,
  posterPath: "posterPath",
  status: "Ended",
  tagline: "",
  type: "Scripted",
  voteAverage: 6.1,
  voteCount: 5,
);

final testTvSeriesDetail = testTvSeriesDetailResponse.toEntity();

final testTvSeriesTable = TvSeriesTable.fromEntity(testTvSeriesDetail);

final testTvSeriesTableList = <TvSeriesTable>[testTvSeriesTable];

final testWatchlistTvSeries = [testTvSeriesTable.toEntity()];

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'name',
};
