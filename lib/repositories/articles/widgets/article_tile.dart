import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:mass_app/repositories/articles/models/article_model.dart';
import 'package:mass_app/repositories/articles/screens/article_read_screen.dart';
import 'package:mass_app/utilities/buttons/circular_button.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({Key? key, required this.article}) : super(key: key);

  final Articles article;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: article.title,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: buttonBR,
          boxShadow: kBoxShadow,
          image: DecorationImage(
            image: ExtendedNetworkImageProvider(article.image, cache: true),
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                const Color(0xff1B1869).withOpacity(0.3), BlendMode.multiply),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.title.vidText,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (c) =>
                                ArticleReadScreen(article: article)),
                      );
                    },
                    text: 'READ MORE',
                    filled: true),
                article.category.vidSText
              ],
            )
          ],
        ),
      ),
    );
  }
}
