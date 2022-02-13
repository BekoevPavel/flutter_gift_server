import 'package:flutter/material.dart';
import 'package:flutter_gift_server/data/wishs_model_datasourse.dart';
import 'package:flutter_gift_server/domain/data.dart';
import 'package:flutter_gift_server/domain/entity/wishyou_entity.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:localstorage/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:universal_html/html.dart" as html;
import 'package:firebase/firebase.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'presentation/widgets/list_wishyou_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DateController.getInstance().wishToFireBace =
      WishsFirebaseDataSourse.initialize();
  await DateController.getInstance().wishToFireBace.initDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var tr = FirebaseFirestore.instance
    //     .collection('wishs')
    //     .doc('mU819tbxU7Z4OlbBiBSP')
    //     .update({'wishyou': 'Ты очень красивая кста21'});

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Админка для пожеланий'),
        ),
        body: Center(child: FirstPage()),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();

    return Container(
        child: Form(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Ваше пожелание',
                      hintText: 'Желаю быть аху..',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  _selectDate(context);
                },
                icon: const Icon(Icons.calendar_today_outlined),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              WishYouEntity entity = WishYouEntity(
                  wishyou: _textController.text, date: selectedDate);
              var wishs = DateController.getInstance().wishs;
              wishs.add(entity);

              var wishToFB = DateController.getInstance().wishToFireBace;

              wishToFB.addWishYou(_textController.text, selectedDate);
            },
            child: const Text('Отправить'),
          ),
          const Divider(),
          ListWishYou(),
        ],
      ),
    ));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    selectedDate = selected ?? selectedDate;
  }
}
