import 'package:flutter/material.dart';
import 'package:m0vieapp/models/search.dart';
import 'package:m0vieapp/utils/constants.dart';
import 'package:m0vieapp/utils/remote_service.dart';

class SearchActivity extends StatefulWidget {
  const SearchActivity({Key? key}) : super(key: key);

  @override
  State<SearchActivity> createState() => _SearchActivityState();
}

class _SearchActivityState extends State<SearchActivity> {
  List<SearchResult>? searchResults;
  Searching searching = Searching.stopped;

  search(expression) async {
    searching = Searching.loading;
    searchResults = await RemoteService().search(expression);
    if (searchResults != null) {
      setState(() {
        searching = Searching.completed;
      });
    } else {
      setState(() {
        searching = Searching.failed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Movies or Series',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSubmitted: (value) {
                  search(value);
                },
              ),
              searching == Searching.stopped
                  ? const Text('Search by entering a keyword')
                  : searching == Searching.loading
                      ? const CircularProgressIndicator()
                      : searching == Searching.failed
                          ? const Text('Something went wrong')
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: searchResults!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      searchResults![index].title,
                                    ),
                                    leading: Image.network(
                                      searchResults![index].image,
                                    ),
                                    dense: false,
                                    onTap: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.of(context).pushNamed(
                                            '/movieInfo',
                                            arguments:
                                                searchResults![index].id);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
            ],
          ),
        ),
      ),
    );
  }
}
