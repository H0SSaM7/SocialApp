import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';

class PostsTap extends StatelessWidget {
  const PostsTap({Key? key, required this.value}) : super(key: key);
  final String value;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('name', isLessThanOrEqualTo: value)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
// profile image -----------------------
                    ClipRRect(
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(
                            snapshot.data!.docs[index].data()['profileImage']),
                      ),
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
