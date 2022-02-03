import 'package:flutter/material.dart';

class AdvertiseCard extends StatelessWidget {
  const AdvertiseCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.network(
            'https://image.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg',
            height: 185,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Communicate with friends',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
