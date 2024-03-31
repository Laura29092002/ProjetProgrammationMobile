import 'package:projet/models/detail_character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/fetch/fetch_detail_character.dart';

abstract class CharacterEvent {}

class FetchCharacterDetail extends CharacterEvent {
  final String apiDetailUrl;

  FetchCharacterDetail(this.apiDetailUrl);
}

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoadInProgress extends CharacterState {}

class CharacterLoadSuccess extends CharacterState {
  final CharacterDetail characterDetail;

  CharacterLoadSuccess(this.characterDetail);
}

class CharacterLoadFailure extends CharacterState {}


class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterInitial()) {
    on<FetchCharacterDetail>((event, emit) async {
      emit(CharacterLoadInProgress());
      try {
        final characterDetail = await fetchCharacterDetail(event.apiDetailUrl);
        emit(CharacterLoadSuccess(characterDetail));
      } catch (_) {
        emit(CharacterLoadFailure());
      }
    });
  }
}
