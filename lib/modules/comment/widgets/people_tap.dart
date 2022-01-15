import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart ';

class PeopleTap extends StatelessWidget {
  const PeopleTap({Key? key, required this.value}) : super(key: key);
  final String value;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .where('name', isLessThanOrEqualTo: value)
          .get(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
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
                      backgroundImage: NetworkImage(
                          snapshot.data!.docs[index].data()['personalImage']),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      snapshot.data!.docs[index].data()['name'],
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
// date of the post --------------
                  ],
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        } else {
          return const Center(
            child: Text('Nothing to show '),
          );
        }
      },
    );
  }
}
