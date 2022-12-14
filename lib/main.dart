import 'dart:convert';
import 'package:untitled2/utils/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:string_to_hex/string_to_hex.dart';
import 'package:collection/collection.dart';
import 'package:untitled2/models/product.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: list(),
    );
  }
}

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  List<Producto> productos = [];
  ScrollController? _scrollController;

  Future initialize() async {
    //ojo
    //movies = List<Movie>();
    loadMore();
    // initScrollController();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Moviesss'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: productos.length,
        itemBuilder: (BuildContext context, int index) {
          return MyHomePage(productos[index]);
        },
      ),
    );
  }

  void loadMore() {
    String body = "";

    getData().then((response) => {
          body = utf8.decode(response.bodyBytes),

          // print(jsonDecode(body)["products"]),
          for (var elemento in jsonDecode(body)["products"])
            {
              setState(() {
                productos.add(Producto(elemento["id"], elemento["title"],
                    elemento["image"], elemento["imageType"], false));

                // isFavorite(Producto(elemento["id"], elemento["title"],elemento["image"], elemento["imageType"], favorite));
              }),
            },
          // helper.getLists().then((value) => {for (var i in productos) {}})
        });
    // helper!.getUpcoming(page.toString()).then((value) {
    //   movies += value;
    //   setState(() {
    //     moviesCount = movies.length;
    //     movies = movies;
    //     page++;
    //   });

    //   if (movies.length % 20 > 0) {
    //     loading = false;
    //   }
    // });
  }
}

Future<http.Response> getData() async {
  final response = await http.get(Uri.parse(
      "https://api.spoonacular.com/food/products/search?query=arroz&number=20&apiKey=979b107215934f4786cde0970b5cfe0a"));
  return response;
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});
  // final String title;
  final Producto producto;
  MyHomePage(this.producto);

  @override
  _MyHomePageState createState() => _MyHomePageState(producto);
}

class _MyHomePageState extends State<MyHomePage> {
  Producto producto;
  _MyHomePageState(this.producto);

  late bool favorite;
  late DbHelper dbHelper;
  // @override
  void initState() {
    favorite = false;
    dbHelper = DbHelper();
    isFavorite(producto);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(widget.producto!.title),
          leading: Image.network(widget.producto!.image),
          trailing: IconButton(
            icon: Icon(Icons.favorite),
            color: favorite ? Colors.red : Colors.grey,
            onPressed: () {
              favorite
                  ? dbHelper.deleteProduct(producto)
                  : dbHelper.insertList(producto);
              setState(() {
                favorite = !favorite;
                producto.isFavorite = favorite;
              });
            },
          )),
    );
  }

  Future isFavorite(Producto producto) async {
    await dbHelper.openDb();
    favorite = await dbHelper.isFavorite(producto);
    setState(() {
      producto.isFavorite = favorite;
    });
  }
}



              // setState(() {
              //   if (colors[index] == Colors.red) {
              //     colors[index] = Colors.grey;
              //     helper.deleteProduct(productos[index]);
              //   } else {
              //     colors[index] = Colors.red;
              //     helper.insertList(productos[index]);
              //   }
              //   // helper.getLists().then((value) => {
                          //       for (var i in value)
                          //         {print(i.id.toString() + "" + i.image)}
                          //     });