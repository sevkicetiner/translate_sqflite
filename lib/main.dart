import 'package:flutter/material.dart';
import 'Model/DbHelper.dart';
import 'Model/Word.dart';
import 'dart:async';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  String inputText = "";
  String submitText = "";
  List<Word> words;
  DbHelper _dbHelper;
  List<Word> list = new List<Word>();
  @override
  void initState() {
    _dbHelper = DbHelper();
    super.initState();
  }

  Future<void> refresh () async {
    var gelen = await _dbHelper.getWords();
    setState(() {
      list = gelen;
    });
  }

  @override
  Widget build(BuildContext context) {

  TextEditingController textController =new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Translate and Save"),
      ),
      body:
      FutureBuilder(
              future: _dbHelper.getWords(),
              builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot){
                list = snapshot.data;
                if(!snapshot.hasData){
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.data == null){
                  return Container(
                    alignment: Alignment.center,
                    child: Text("Word list is empty"),
                  );
                }
                  return GestureDetector(
                    onTap: (){

                    },
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: textController,
                          onSubmitted: (value) {
                            _dbHelper.insertWord(Word(value, "girilen"));
                            refresh();
                          },
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                              itemBuilder: (BuildContext context, int index){
                            return Text(list[list.length-index-1].orginalText);
                          }),
                        )
                      ],
                    ),
                  );
              },
            ),

    );
  }
}
