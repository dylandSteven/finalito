import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/screens/favourite_product.dart';
import 'package:untitled2/screens/find_product.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('hola'),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Row contents horizontally,

          children: [
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => listProduct()),
                      )
                    },
                child: Text('List Products')),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => favouriteProduct()),
                      )
                    },
                child: Text('Favourite Products'))
          ],
        ),
      ]),
    );
  }
}

// assign(index) {
//   if (index == 1) {
//     return Text('uno');
//   }
//   if (index == 4) {
//     return Row(children: [
//       ElevatedButton(
//         child: Text('list'),
//         onPressed: () => {},
//       ),
//       ElevatedButton(
//         child: Text('favorite'),
//         onPressed: () => {},
//       )
//     ]);
//   }
// }
