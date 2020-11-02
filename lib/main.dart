import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

List data;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future getData() async{
    String url = "https://jsonplaceholder.typicode.com/users";
    try {
      http.Response response = await http.get(url);
      if(response.statusCode ==200) {
        print("Data Fetched Successfully");
        data = json.decode(response.body);
        return data;
      } 
    }catch (e) {
      print(e);
      print("No Data Fetched");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FUTURE-BUILDER", style: TextStyle(color: Colors.black, letterSpacing: 2.0, fontWeight: FontWeight.w400),),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 10.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.redAccent,
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text("INFORMATION", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text("Id: "+snapshot.data[index]["id"].toString()),
                            Text("Name: "+snapshot.data[index]["name"]),
                            Text("UserName: "+snapshot.data[index]["username"]),
                            Text("E-Mail: "+snapshot.data[index]["email"]),
                            SizedBox(height: 20.0),
                            Text("ADDRESS", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text("Street: "+snapshot.data[index]["address"]["street"]),
                            Text("Suite "+snapshot.data[index]["address"]["suite"]),
                            Text("City: "+snapshot.data[index]["address"]["city"]),
                            Text("ZipCode: "+snapshot.data[index]["address"]["zipcode"].toString()),
                            Text("Geo: "+snapshot.data[index]["address"]["geo"].toString()),
                            SizedBox(height: 20.0),
                            Text("CONTACT INFORMATION", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text("Phone: "+snapshot.data[index]["phone"].toString()),
                            Text("Website: "+snapshot.data[index]["website"]),
                            SizedBox(height: 20.0),
                            Text("COMPANY DETAILS", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text("Company Name: "+snapshot.data[index]["company"]["name"]),
                            Text("Company Phrase: "+snapshot.data[index]["company"]["catchPhrase"]),
                            Text("Company BS: "+snapshot.data[index]["company"]["bs"]),
                          ]
                        ),
                      ),
                    ),
                  );
                }
              );
            }
            else{
              return Center
              (
                child: Container
                (
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(strokeWidth: 5.0,)
                )
              );
            }
          },
        ),
      ),
    );
  }
}
