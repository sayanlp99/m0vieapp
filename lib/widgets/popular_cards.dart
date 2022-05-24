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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                      ),
                    ),
                    Text(
                      widget.crew,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 10,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.year,
                          style: TextStyle(
                            fontSize: MediaQuery.textScaleFactorOf(context) * 9,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star_half,
                          size: MediaQuery.textScaleFactorOf(context) * 10,
                          color: Colors.yellow.shade800,
                        ),
                        Text(
                          widget.rating,
                          style: TextStyle(
                            fontSize: MediaQuery.textScaleFactorOf(context) * 9,
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
