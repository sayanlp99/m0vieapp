import 'package:flutter/material.dart';

class PopularCards extends StatefulWidget {
  final String title;
  final String year;
  final String img;
  final String crew;
  final String rating;
  final String id;
  const PopularCards({
    Key? key,
    required this.title,
    required this.year,
    required this.img,
    required this.crew,
    required this.rating,
    required this.id,
  }) : super(key: key);

  @override
  State<PopularCards> createState() => _PopularCardsState();
}

class _PopularCardsState extends State<PopularCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 7),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.img),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.crew,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.year,
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star_half,
                          size: 13,
                          color: Colors.yellow.shade800,
                        ),
                        Text(
                          widget.rating,
                          style: const TextStyle(
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
    );
  }
}
