import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Listdata extends StatefulWidget {
  const Listdata({super.key});

  @override
  State<Listdata> createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {
  final auth = FirebaseAuth.instance;
  final data = FirebaseFirestore.instance.collection('All_data').snapshots();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //  Title of user screen


                    //user lists
                    SizedBox(
                      height: 300,
                      child: StreamBuilder(
                        stream: data,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                                child: Text(
                                  "user not found.",

                                ));
                          } else {}

                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var db = snapshot.data!.docs[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 35, right: 33, top: 5),
                                  child: Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),

                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: Text(
                                                db['_textController'].toString()),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: Text(db['_imageFile'].toString()),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child:
                                            Text(db['_pdfFile'].toString()),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}