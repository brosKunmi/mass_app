import 'package:flutter/material.dart';
import 'package:mass_app/repositories/articles/models/article_category.dart';
import 'package:mass_app/repositories/articles/models/article_model.dart';
import 'package:mass_app/repositories/articles/screens/article_list_screen.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class ArticleCat extends StatelessWidget {
  const ArticleCat({Key? key, required this.cart, required this.catArt})
      : super(key: key);

  final ArticleCategory cart;
  final List<Articles> catArt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => ArticleListScreen(
                  articles: catArt,
                  cat: cart,
                )));
      },
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.6,
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.7),
          borderRadius: otherBR,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: commonOR,
                topRight: commonOR,
              ),
              child: Image.asset(
                cart.catImage.png,
                width: MediaQuery.of(context).size.width * 0.6,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cart.catTitle.vidText,
                  cart.catDesc.vidSText,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
