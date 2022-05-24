import 'package:flutter/material.dart';

class ComingSoonCards extends StatefulWidget {
  final String title;
  final String img;
  final String releaseDate;
  final String stars;
  final String id;
  const ComingSoonCards({
    Key? key,
    required this.title,
    required this.img,
    required this.releaseDate,
    required this.stars,
    required this.id,
  }) : super(key: key);

  @override
  State<ComingSoonCards> createState() => _ComingSoonCardsState();
}

class _ComingSoonCardsState extends State<ComingSoonCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 180,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(226, 0, 0, 0),
            image: DecorationImage(
              image: NetworkImage(widget.img),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(167, 0, 0, 0).withOpacity(0.5),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.releaseDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.stars,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
