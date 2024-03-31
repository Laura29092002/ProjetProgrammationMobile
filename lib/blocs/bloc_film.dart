import 'package:projet/models/film.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/fetch/fetch_film.dart';

abstract class FilmEvent {}

class FetchFilms extends FilmEvent {
  final int numberOfElements;

  FetchFilms({required this.numberOfElements});
}

abstract class FilmState {}

class FilmsInitial extends FilmState {}

class FilmsLoadInProgress extends FilmState {}

class FilmsLoadSuccess extends FilmState {
  final List<Film> films;

  FilmsLoadSuccess(this.films);
}

class FilmsLoadFailure extends FilmState {}


class FilmBloc extends Bloc<FilmEvent, FilmState> {
  FilmBloc() : super(FilmsInitial()) {
    on<FetchFilms>((event, emit) async {
      emit(FilmsLoadInProgress());
      try {
        final films = await fetchFilms(event.numberOfElements);
        emit(FilmsLoadSuccess(films));
      } catch (_) {
        emit(FilmsLoadFailure());
      }
    });
  }
}

