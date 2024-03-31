import 'package:projet/models/comic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/fetch/fetch_comic.dart';

abstract class ComicEvent {}

class FetchComics extends ComicEvent {
  final int numberOfElements;

  FetchComics({required this.numberOfElements});
}


abstract class ComicState {}

class ComicsInitial extends ComicState {}

class ComicsLoadInProgress extends ComicState {}

class ComicsLoadSuccess extends ComicState {
  final List<Comic> comics;

  ComicsLoadSuccess(this.comics);
}

class ComicsLoadFailure extends ComicState {}


class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(ComicsInitial()) {
    on<FetchComics>((event, emit) async {
      emit(ComicsLoadInProgress());
      try {
        final comics = await fetchComics(event.numberOfElements);
        emit(ComicsLoadSuccess(comics));
      } catch (_) {
        emit(ComicsLoadFailure());
      }
    });
  }
}
