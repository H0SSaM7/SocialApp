import 'package:flutter/material.dart';
import 'package:social_app/presentation/comment/widgets/people_tap.dart';
import 'package:social_app/presentation/comment/widgets/posts_tap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: buildAppBar(),
          ),
          body: TabBarView(
            children: [
              PostsTap(value: textFieldValue),
              PeopleTap(value: textFieldValue),
            ],
          )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      titleSpacing: 0.0,
      title: Container(
        height: 50,
        padding: const EdgeInsets.only(right: 10),
        child: TextField(
          onChanged: (value) {
            setState(() {
              textFieldValue = value;
            });
          },
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              border: buildOutlineInputBorder(),
              enabledBorder: buildOutlineInputBorder(),
              focusedBorder: buildOutlineInputBorder(),
              hintText: ' Search',
              hintStyle: const TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      bottom: const TabBar(
        tabs: [
          Tab(
            child: Text('Posts'),
          ),
          Tab(
            child: Text('people'),
          )
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.white,
        ));
  }
}
