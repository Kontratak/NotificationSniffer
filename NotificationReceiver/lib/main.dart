import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification_receiver/firebase_ops.dart';

import 'item.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseOps.setFirestore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notif Receiver'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<QuerySnapshot>? chats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
              child: chatMessages()), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Widget chatMessages() {
    return StreamBuilder(
      stream: FirebaseOps.readItems(),
      builder: (context,AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Item message = new Item.fromMap(snapshot.data!.docs[index].data());
                  return MessageTile(
                    data: message.data,
                    app: message.app,
                    image: null,
                  );
                })
            : Center(child: CircularProgressIndicator(),);
      },
    );
  }
}

class MessageTile extends StatefulWidget {
  final String? data;
  final String? app;
  final String? image;

  MessageTile({this.data, this.app, this.image});

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  String? data;
  String? app;
  String? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    app = widget.app;
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(app ?? "",style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
          Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 17, bottom: 17, left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(
                                topLeft: Radius.circular(23),
                                topRight: Radius.circular(23),
                                bottomRight: Radius.circular(23)),
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'OverpassRegular',
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
