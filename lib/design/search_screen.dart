import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_search.dart';
import 'package:projet/models/search.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        backgroundColor: Color(0xFF15232E),
        body: Column(
          children: [
            SearchHeader(),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: SearchLoadingScreen());
                  } else if (state is SearchSuccess) {
                    if (state.searchResults.isEmpty) {
                      return Center(
                        child: Text(
                          "Aucun résultat trouvé.",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    } else {
                      return SearchResults(results: state.searchResults);
                    }
                  } else if (state is SearchFailure) {
                    return Text('Erreur: ${state.error}');
                  }
                  return SearchHintCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
