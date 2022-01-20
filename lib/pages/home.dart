import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _list = [];
  late String _newEl;
  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (BuildContext context){
                return Scaffold(
                  backgroundColor: Colors.grey[900],
                  appBar: AppBar(
                    title: Text('Меню'),
                    backgroundColor: Colors.deepPurple,
                  ),
                  body: Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      }, child: Text('На главную')),
                      Padding(padding: EdgeInsets.only(left: 15)),
                      Text('Меню')
                    ],
                  )
                );
              })
            );
          }, icon: Icon(Icons.menu_outlined), color: Colors.white)
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Text('Нет записей');
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child:
                      ListTile(
                        title: Text(snapshot.data!.docs[index].get('items')),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.deepPurple,
                          ),
                          onPressed: (){
                            FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                          }
                          ,
                        ),
                      ),
                    ),
                    onDismissed: (direction){
                      FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                    },
                  );
                },
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
            title: Text('Добавить элемент'),
            content: TextField(
              onChanged: (String value){
                setState(() {
                  _newEl = value;
                });
    },
    ),
              actions: [
                ElevatedButton(onPressed: (){
                  FirebaseFirestore.instance.collection('items').add({'items':_newEl});
                  Navigator.of(context).pop();
                }, child: Text('Добавить'))
              ],
            );
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
