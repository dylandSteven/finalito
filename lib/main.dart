import 'dart:convert';
import 'dart:ffi';
import 'package:untitled2/utils/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:string_to_hex/string_to_hex.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // helper.testDB();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<Color> colors = [];

  DbHelper helper = DbHelper();

  List<Producto> productos = [];

  List<String> cadenas = [];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  String body = "";

  Future<http.Response> getData() async {
    final response = await http.get(Uri.parse(
        "https://api.spoonacular.com/food/products/search?query=arroz&number=20&apiKey=979b107215934f4786cde0970b5cfe0a"));
    return response;
  }

  @override
  void initState() {
    super.initState();
    getData().then((response) => {
          body = utf8.decode(response.bodyBytes),
          // print(jsonDecode(body)["products"]),
          for (var elemento in jsonDecode(body)["products"])
            {
              productos.add(Producto(elemento["id"], elemento["title"],
                  elemento["image"], elemento["imageType"])),
              colors.add(Colors.red)
            },
          helper.getLists().then((value) => {
            for(var i in productos){
              
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(children: [
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(productos[index].title),
                    leading: Image.network(productos[index].image),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: colors[index]),
                      onPressed: () {
                        // products.title = productos[index].title;
                        // products.image = productos[index].image;
                        // products.imageType = productos[index].imageType;

                        setState(() {
                          if (colors[index] == Colors.amber) {
                            colors[index] = Colors.red;
                            helper.deleteProduct(productos[index]);
                          } else {
                            colors[index] = Colors.amber;
                            helper.insertList(productos[index]);
                          }
                          helper.getLists().then((value) => {
                                for (var i in value)
                                  {print(i.id.toString() + "" + i.image)}
                              });
                        });
                      },
                    ),
                  ),
                );
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Producto {
  int id;
  String title;
  String image;
  String imageType;

  Producto(this.id, this.title, this.image, this.imageType);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'title': title,
      'image': image,
      'imageType': imageType
    };
  }
}
