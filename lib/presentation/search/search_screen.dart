import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/search_controller/search_bloc.dart';
import 'package:social_app/data/repository/search_repo/search_repository.dart';
import 'package:social_app/presentation/search/widgets/post_tap.dart';
import 'package:social_app/presentation/search/widgets/people_tap_.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(searchRepository: SearchRepository()),
      child: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: buildAppBar(context),
            ),
            body: const TabBarView(
              children: [
                PostsTap(
                  value: 'non',
                ),
                PeopleTap(),
              ],
            )),
      ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      titleSpacing: 0.0,
      title: Container(
        height: 50,
        padding: const EdgeInsets.only(right: 10),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return TextField(
              onChanged: (value) =>
                  context.read<SearchBloc>().add(OnSearchBarChangeEvent(value)),
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
            );
          },
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
