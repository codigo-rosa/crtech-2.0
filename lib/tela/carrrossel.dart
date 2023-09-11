import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carrossel extends StatelessWidget {
  final List<String> imageList = [
    "assets/carrossel/1.png",
    "assets/carrossel/2.png",
    "assets/carrossel/3.png",
    "assets/carrossel/4.png",
    "assets/carrossel/5.png",
    "assets/carrossel/6.png"
  ];

  Carrossel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height:
            270, // Ajuste a altura de acordo com a dimensão original da imagem
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        aspectRatio: 2,
        viewportFraction: 1,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        scrollDirection: Axis.horizontal,
        pauseAutoPlayOnManualNavigate: true,
      ),
      items: imageList.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
