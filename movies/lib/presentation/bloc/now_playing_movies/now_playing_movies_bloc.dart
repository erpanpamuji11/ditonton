import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movies/movie.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<OnNowPlayingMovieCalled>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingMovieError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(NowPlayingMovieEmpty())
            : emit(NowPlayingMovieHasData(data));
      });
    });
  }
}
