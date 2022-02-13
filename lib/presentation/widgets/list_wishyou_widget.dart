import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gift_server/domain/data.dart';
import 'package:flutter_gift_server/domain/entity/wishyou_entity.dart';

import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class ListWishYou extends StatelessWidget {
  ListWishYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage('some_key');

    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('wishs').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              //print(snapshot.data!.docs.first.get('wishyou'));
              return _listWishs(context, snapshot.data!.docs);
            }

            return Container(width: 200, height: 200, child: Text(''));
          },
        ),
      ],
    );
  }
}

Widget _listWishs(
    BuildContext context, List<QueryDocumentSnapshot<Object?>> docs) {
  var wishs = DateController.getInstance().wishs;
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
      color: Color.fromARGB(100, 255, 100, 23),
    ),
    padding: const EdgeInsets.all(10),
    width: 800,
    height: 400,
    child: ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        wishs;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    docs[index].get('wishyou'),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(
                  _getData(
                    docs[index].get('date'),
                  ),
                  //wishs[index].wishyou ?? 'None',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    onPressed: () {
                      var deleted = docs[index].id;
                      FirebaseFirestore.instance
                          .collection('wishs')
                          .doc(deleted)
                          .delete();
                    },
                    icon: const Icon(Icons.mode_edit_outlined))
              ],
            ),
            const Divider(),
          ],
        );
      },
    ),
  );
}

String _getData(dynamic date1) {
  // var test = date() as Map<String, dynamic>;
  Timestamp stamp = date1 as Timestamp;
  DateTime date = stamp.toDate();
  //print(date);
  return date.toString();
}
