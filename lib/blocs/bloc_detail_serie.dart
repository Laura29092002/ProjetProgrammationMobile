import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/models/detail_serie.dart';
import 'package:projet/fetch/fetch_detail_serie.dart';

abstract class SerieDetailEvent {}

class FetchSerieDetail extends SerieDetailEvent {
  final String apiDetailUrl;

  FetchSerieDetail({required this.apiDetailUrl});
}

class FetchEpisodes extends SerieDetailEvent {
  final List<String> episodeUrls;

  FetchEpisodes({required this.episodeUrls});
}

abstract class SerieDetailState {}

class SerieDetailInitial extends SerieDetailState {}

class SerieDetailLoading extends SerieDetailState {}

class SerieDetailLoaded extends SerieDetailState {
  final SerieDetail serieDetail;

  SerieDetailLoaded({required this.serieDetail});
}

class SerieDetailError extends SerieDetailState {
  final String message;

  SerieDetailError({required this.message});
}

class EpisodesLoading extends SerieDetailState {}

class EpisodesLoaded extends SerieDetailState {
  final List<Episode> episodes;

  EpisodesLoaded({required this.episodes});
}

class EpisodesError extends SerieDetailState {
  final String message;

  EpisodesError({required this.message});
}



class SerieDetailBloc extends Bloc<SerieDetailEvent, SerieDetailState> {
  SerieDetailBloc() : super(SerieDetailInitial()) {
    on<FetchSerieDetail>((event, emit) async {
      emit(SerieDetailLoading());
      try {
        final serieDetail = await fetchSerieDetail(event.apiDetailUrl);
        emit(SerieDetailLoaded(serieDetail: serieDetail));

      } catch (e) {
        emit(SerieDetailError(message: e.toString()));
      }
    });

    on<FetchEpisodes>((event, emit) async {
      emit(EpisodesLoading());
      try {
        final episodes = await fetchAllEpisodes(event.episodeUrls);
        emit(EpisodesLoaded(episodes: episodes));
      } catch (e) {
        emit(EpisodesError(message: e.toString()));
      }
    });
  }
}
