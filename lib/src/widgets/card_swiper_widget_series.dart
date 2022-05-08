import 'package:flutter/material.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:peliculas_app/src/models/tv_model.dart';

class CardSwiperSeries extends StatelessWidget {
  final List<Serie> series;

  CardSwiperSeries({required this.series});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          series[index].uniqueId = '${series[index].id}-tarjeta';

          return Hero(
            tag: series[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalleserie',
                    arguments: series[index]),
                child: FadeInImage(
                  image: NetworkImage(series[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
