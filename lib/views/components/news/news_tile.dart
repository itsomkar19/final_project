import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'article_view.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, articleUrl;

  const NewsTile(
      {super.key,
      required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.articleUrl});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      articleUrl: articleUrl,
                    )));
      },
      child: Container(
        // color: Colors.pink,
          margin: const EdgeInsets.only(bottom: 12, top: 12),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                    height: 200,
                    width: width,
                    imageUrl: imgUrl,
                    placeholder: (context, url) =>
                        // const LottieAnimationView(
                        //   animation: LottieAnimation.squares,
                        //   repeat: true,
                        // ),
                    const Icon(Icons.downloading),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  desc,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}
