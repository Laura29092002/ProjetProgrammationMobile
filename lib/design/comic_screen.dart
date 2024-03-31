import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_comic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'detail_comic_screen.dart';

class ComicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComicBloc()..add(FetchComics(numberOfElements: 50)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comics les plus populaires',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          backgroundColor: Color(0xFF15232E),
        ),
        body: Container(
          color: Color(0xFF15232E),
          child: BlocBuilder<ComicBloc, ComicState>(
            builder: (context, state) {
              if (state is ComicsLoadInProgress) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ComicsLoadSuccess) {
                return ListView.builder(
                  itemCount: state.comics.length,
                  itemBuilder: (context, index) {
                    final comic = state.comics[index];
                    return InkWell(
                      onTap: () {
                        print("Tapped on item ${comic.apiDetailUrl}");
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComicDetailPage(apiDetailUrl: comic.apiDetailUrl, comic: comic)
                      ),
                    );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 21, bottom: 21),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E3243),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 21, bottom: 12, left: 14),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        comic.imageUrl,
                                        width: 129,
                                        height: 163,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        '#${index + 1}',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        comic.name,
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/ic_books_bicolor.svg',
                                            width: 15,
                                            height: 16,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'N°${comic.issueNumber}',
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/ic_calendar_bicolor.svg',
                                            width: 14,
                                            height: 14,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            '${comic.coverDate}',
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ComicsLoadFailure) {
                return Center(child: Text("Erreur de chargement"));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
        );
  }
}
