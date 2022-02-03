import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/search_controller/search_bloc.dart';

class PeopleTap extends StatelessWidget {
  const PeopleTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const Center(
            child: Text('Search results for people. '),
          );
        } else if (state is LoadingSearchDataState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is UpdateSearchResultState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
// profile image -----------------------
                    CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          NetworkImage(state.searchResult[index].profileImage!),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      state.searchResult[index].name!,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
// date of the post --------------
                  ],
                ),
              );
            },
            itemCount: state.searchResult.length,
          );
        } else if (state is SearchListEmptyResultState) {
          return const Center(
            child: Text('There is no result of this name!!'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
