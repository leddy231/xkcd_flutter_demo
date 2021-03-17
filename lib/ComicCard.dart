import 'package:flutter/material.dart';
import 'Backend.dart';
import 'dart:ui';

class ComicCard extends StatelessWidget {
  final Comic comic;

  ComicCard(this.comic);

  @override
  Widget build(BuildContext ctx) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Text(
                comic.title,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Text(
                comic.getDateString(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: Image.network(comic.imgUrl),
            ),
          ],
        ),
      );
}
