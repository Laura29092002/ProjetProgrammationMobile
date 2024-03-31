import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/fetch/fetch_detail_comic.dart';
import 'package:projet/models/detail_comic.dart';

abstract class ComicEvent {}

class FetchComicDetail extends ComicEvent {
  final String apiDetailUrl;

  FetchComicDetail(this.apiDetailUrl);
}

abstract class ComicState {}

class ComicInitial extends ComicState {}

class ComicLoadInProgress extends ComicState {}

class ComicLoadSuccess extends ComicState {
  final ComicDetail comicDetail;

  ComicLoadSuccess(this.comicDetail);
}

class ComicLoadFailure extends ComicState {}


class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(ComicInitial()) {
    on<FetchComicDetail>((event, emit) async {
      emit(ComicLoadInProgress());
      try {
        final comicDetail = await fetchComicDetail(event.apiDetailUrl);
        emit(ComicLoadSuccess(comicDetail));
      } catch (_) {
        emit(ComicLoadFailure());
      }
    });
  }
}
