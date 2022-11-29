import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled2/models/product.dart';
import 'package:untitled2/screens/find_product.dart';
import 'package:untitled2/utils/dbhelper.dart';

class favouriteProduct extends StatefulWidget {
  @override
  State<favouriteProduct> createState() => _favouriteProductState();
}

class _favouriteProductState extends State<favouriteProduct> {
  late DbHelper dbHelper = DbHelper();
  late bool favorite;
  List<Producto> lista = [];

  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Favourite Products')),
        body: Column(
          children: [for (var i in lista) data(i)],
        ));
  }

  data(i) {

    return Center(
        child: Card(
            child: ListTile(
      title: Text(i.title),
      leading: Image.network(i.image),
    )));
  }

  Future getFavorites() async {
    await dbHelper.openDb();
    lista = await dbHelper.getLists();
    setState(() {
      lista = lista;
    });
  }
}
