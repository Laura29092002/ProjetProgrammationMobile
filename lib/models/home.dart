import 'package:flutter/material.dart';
import 'package:projet/models/comic.dart';
import 'package:projet/models/film.dart';
import 'package:projet/models/serie.dart';
import 'package:projet/models/character.dart';
import 'package:projet/models/actualité.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projet/design/detail_comic_screen.dart';
import 'package:projet/design/detail_serie_screen.dart';
import 'package:projet/design/detail_film_screen.dart';
import 'package:projet/design/detail_character_screen.dart';


class ComicsList extends StatelessWidget {
  final List<Comic> comics;

  ComicsList({required this.comics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comics.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            comics[index].imageUrl,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(comics[index].name),
          subtitle: Text('#${comics[index].issueNumber}'),
        );
      },
    );
  }
}


class FilmsList extends StatelessWidget {
  final List<Film> films;

  FilmsList({required this.films});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: films.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            films[index].imageUrl,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(films[index].name),
        );
      },
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Serie> series;

  SeriesList({required this.series});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: series.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            series[index].imageUrl,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(series[index].name),
        );
      },
    );
  }
}

class ComicsRow extends StatelessWidget {
  final List<Comic> comics;

  ComicsRow({required this.comics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: comics.map((comic) => ComicItem(comic: comic)).toList(),
      ),
    );
  }
}

class ComicItem extends StatelessWidget {
  final Comic comic;

  ComicItem({required this.comic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicDetailPage(apiDetailUrl: comic.apiDetailUrl, comic: comic),
          ),
        );
      },
      child: Container(
        width: 210,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 242,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      comic.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF284C6A),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      '${comic.name} #${comic.issueNumber}',
                      style: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class FilmsRow extends StatelessWidget {
  final List<Film> films;

  FilmsRow({required this.films});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: films.map((film) => FilmItem(film: film)).toList(),
      ),
    );
  }
}



class FilmItem extends StatelessWidget {
  final Film film;

  FilmItem({required this.film});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmDetailPage(apiDetailUrl: film.apiDetailUrl, film: film),
          ),
        );
      },
      child: Container(
        width: 210,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 242,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      film.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF284C6A),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      film.name,
                      style: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}


class CharactersRow extends StatelessWidget {
  final List<Character> characters;

  CharactersRow({required this.characters});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: characters.map((character) => CharacterItem(character: character)).toList(),
      ),
    );
  }
}

class CharacterItem extends StatelessWidget {
  final Character character;

  CharacterItem({required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailPage(apiDetailUrl: character.apiDetailUrl),
          ),
        );

      },

      child: Container(
        width: 210,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 242,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      character.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF284C6A),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      character.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class SeriesRow extends StatelessWidget {
  final List<Serie> series;

  SeriesRow({required this.series});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: series.map((serie) => SerieItem(serie: serie)).toList(),
      ),
    );
  }
}

class SerieItem extends StatelessWidget {
  final Serie serie;

  SerieItem({required this.serie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SerieDetailPage(apiDetailUrl: serie.apiDetailUrl, serie: serie),
          ),
        );
      },
      child: Container(
        width: 210,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 242,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      serie.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF284C6A),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      serie.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ArticlesColumn extends StatelessWidget {
  final List<Article> articles;

  ArticlesColumn({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: articles.map((article) => ArticleItem(article: article)).toList(),
    );
  }
}


class ArticleItem extends StatelessWidget {
  final Article article;

  ArticleItem({required this.article});

  @override
  Widget build(BuildContext context) {
    // Obtient la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(article.siteDetailUrl);
        if(!await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        )){
          throw Exception('Could not launch $uri');
        }
      },
      child: Container(
        width: screenWidth,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.imageUrl,
                    width: screenWidth - 16,
                    height: 242,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF284C6A),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      article.title,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Nunito'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}


