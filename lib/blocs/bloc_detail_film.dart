import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/fetch/fetch_detail_film.dart';
import 'package:projet/models/detail_film.dart';

abstract class FilmEvent {}

class FetchFilmDetail extends FilmEvent {
  final String apiDetailUrl;

  FetchFilmDetail(this.apiDetailUrl);
}

abstract class FilmState {}

class FilmInitial extends FilmState {}

class FilmLoadInProgress extends FilmState {}

class FilmLoadSuccess extends FilmState {
  final FilmDetail filmDetail;

  FilmLoadSuccess(this.filmDetail);
}

class FilmLoadFailure extends FilmState {}


class FilmBloc extends Bloc<FilmEvent, FilmState> {
  FilmBloc() : super(FilmInitial()) {
    on<FetchFilmDetail>((event, emit) async {
      emit(FilmLoadInProgress());
      try {
        final filmDetail = await fetchFilmDetail(event.apiDetailUrl);
        emit(FilmLoadSuccess(filmDetail));
      } catch (_) {
        emit(FilmLoadFailure());
      }
    });
  }
}
