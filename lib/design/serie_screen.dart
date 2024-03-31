import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/blocs/bloc_serie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/design/detail_serie_screen.dart';

class SeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SerieBloc()..add(FetchSeries(numberOfElements: 50)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Séries les plus populaires',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          backgroundColor: Color(0xFF15232E),
        ),
        body: BlocBuilder<SerieBloc, SerieState>(
          builder: (context, state) {
            if (state is SeriesLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SeriesLoadSuccess) {
              return Container(
                color: Color(0xFF15232E),
                child: ListView.builder(
                  itemCount: state.series.length,
                  itemBuilder: (context, index) {
                    final serie = state.series[index];
                    return InkWell(
                      onTap: () {
                        print("Tapped on item ${serie.apiDetailUrl}");
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SerieDetailPage(apiDetailUrl: serie.apiDetailUrl, serie: serie),
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
                                        serie.imageUrl,
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
                                        serie.name,
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
                                            'assets/images/ic_publisher_bicolor.svg',
                                            width: 15,
                                            height: 12,
                                            color: Color(0xFF69727D),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            '${serie.publisherName}',
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
                                            'assets/images/ic_tv_bicolor.svg',
                                            width: 15,
                                            height: 11,
                                            color: Color(0xFF69727D),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            '${serie.countOfEpisodes} épisodes',
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
                                            '${serie.startYear}',
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
                ),
              );
            } else if (state is SeriesLoadFailure) {
              return Center(child: Text("Erreur de chargement"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
