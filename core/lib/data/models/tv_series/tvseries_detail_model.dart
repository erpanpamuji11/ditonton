import 'package:core/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries_detail.dart';

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
        required this.backdropPath,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
    });

    final String? backdropPath;
    final String firstAirDate;
    final List<GenreModel> genres;
    final String homepage;
    final int id;
    final String name;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final String status;
    final String tagline;
    final String type;
    final double voteAverage;
    final int voteCount;

    factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) => TvSeriesDetailResponse(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
    TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

    @override
  // TODO: implement props
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        homepage,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

