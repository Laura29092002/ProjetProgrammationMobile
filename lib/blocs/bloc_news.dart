
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/models/actualité.dart';
import 'package:projet/fetch/fetch_actualité.dart';

abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final int numberOfElements;

  FetchNews({required this.numberOfElements});
}

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> news;

  NewsLoaded({required this.news});
}

class NewsError extends NewsState {
  final String message;

  NewsError({required this.message});
}



class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await fetchArticles(event.numberOfElements);
        emit(NewsLoaded(news: news));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });
  }
}
