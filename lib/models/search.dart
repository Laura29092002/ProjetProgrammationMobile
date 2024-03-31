import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';
import 'package:projet/blocs/bloc_search.dart';

class SearchHeader extends StatefulWidget {
  @override
  _SearchHeaderState createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    final searchTerm = _controller.text;
    if (searchTerm.trim().isEmpty) {
      return;
    }
    // Envoi de l'événement de changement de texte
    context.read<SearchBloc>().add(SearchTextChanged(searchTerm: searchTerm));
    FocusScope.of(context).unfocus();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 10.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recherche',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 45,
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _handleSearch(),
                decoration: InputDecoration(
                  hintText: 'Comic, film, série...',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: AppColors.backgroundScreens,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: AppColors.bottomBarUnselectedItemText),
                    onPressed: _handleSearch,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SearchResults extends StatelessWidget {
  final Map<String, dynamic> results;

  SearchResults({required this.results});

  @override
  Widget build(BuildContext context) {
    List<Widget> categorySections = [];

    void addCategorySection(String categoryKey, String title) {
      if (results.containsKey(categoryKey) && results[categoryKey].isNotEmpty) {
        categorySections.add(
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CategorySection(title: title, items: results[categoryKey]),
          ),
        );
      }
    }

    addCategorySection('series', 'Séries');
    addCategorySection('comics', 'Comics');
    addCategorySection('movies', 'Films');
    addCategorySection('characters', 'Personnages');


    if (categorySections.isEmpty) {
      return Center(
        child: Text(
          'Aucun résultat trouvé.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(left: 16),
      color: AppColors.backgroundScreens,
      child: SingleChildScrollView(
        child: Column(
          children: categorySections,
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<dynamic> items;

  CategorySection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(right: 8.0),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  child: Card(
                    color: AppColors.cardElementBackground,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.network(
                            items[index]['image']['small_url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            items[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchHintCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 360,
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            FractionallySizedBox(
              widthFactor: 0.6,
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1c7ec6),
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Saisissez une recherche pour trouver un '),
                      TextSpan(
                        text: 'comics, film, série ou personnage.',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1c7ec6)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -30,
              right: -8,
              child: SvgPicture.asset(
                'assets/images/astronaut.svg',
                width: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreens,
      body: Center(
        child: Container(
          width: 360,
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF1c7ec6),
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Recherche en cours.\nMerci de patienter'),
                  ],
                ),
              ),
              Positioned(
                top: -136,
                child: SvgPicture.asset(
                  'assets/images/astronaut.svg',
                  width: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

