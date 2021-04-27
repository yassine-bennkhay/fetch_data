import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart 'as http;

import 'model/post.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  Future<Post> postData;
@override
  initState(){
super.initState();
postData=getPostDetails();
  }
  Future<Post> getPostDetails()async{
    http.Response futurePost=
    await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts/1'),);
    if(futurePost.statusCode==200){
    /*if the server return an Ok status code 200 then convert the JSON Map into a Post*/
      return Post.fromJson(jsonDecode(futurePost.body));
    }else{
      /*if the server did not return an status code then throw exception*/
      throw Exception('we cant load your data ');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text('getting data from the internet.'),),
      body: Center(
        child:FutureBuilder(
          future: postData,
          builder: (context,snapShot){
           if(snapShot.hasData){
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
               Text('the user id is: ${snapShot.data.userId}'),
                   Text('the id is : ${snapShot.data.id}'),
                   Text('the title is : ${snapShot.data.title}'),
                   Text('the body is: ${snapShot.data.body}'),
                 ],
               ),
             );
           }else if(snapShot.hasError){
             return Text("${snapShot.error}");
           }
           return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
