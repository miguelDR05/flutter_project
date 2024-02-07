import 'dart:ffi' as ffi;
import 'package:flutter_projects/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hola Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController? _controller;
  int currentPage = 9;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Incrementar',
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        height: 50,
        notchMargin: 8.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.history),
            _bottomAction(FontAwesomeIcons.chartPie),
            const SizedBox(
              width: 48.0,
            ),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings),
          ],
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          _expenses(),
          _graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24.0,
          ),
          _list(),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    Alignment alignment;
    const selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );

    if (position == currentPage) {
      alignment = Alignment.center;
    } else if (position > currentPage) {
      alignment = Alignment.centerRight;
    } else {
      alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: alignment,
      child: Text(name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: const Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        // children: List.generate(12, (index) => _pageItem(getMonthName(index), index)),
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
    );
  }

  Widget _expenses() {
    return const Column(
      children: <Widget>[
        Text("\$2361, 41",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        Text("Gastos totales",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.blueGrey
          ),
        ),
      ],
    );
  }

  Widget _graph() {
    return SizedBox(
      height: 250.0,
      child: GraphWidget(),
    );
  }

  Widget _item(IconData icon, String nombre, int percent, double value) {
    return ListTile(
      leading: Icon(icon, size: 32.0,),
      title: Text(nombre,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
        ),
      ),
      subtitle: Text("$percent% de gastos",
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("\$$value",
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _list() {
  //   return Expanded(
  //       child: ListView(
  //
  //         children: <Widget>[
  //           _item(FontAwesomeIcons.shoppingCart, "Compras", 14, 145.12),
  //           _item(FontAwesomeIcons.wineGlass, "Alcohol", 5, 73.57),
  //           _item(FontAwesomeIcons.burger, "Comida Rapida", 14, 145.12),
  //           _item(FontAwesomeIcons.wallet, "Cine", 14, 145.12),
  //           _item(FontAwesomeIcons.shirt, "Ropa", 14, 145.12),
  //         ],
  //     ),
  //   );
  // }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) => _item(FontAwesomeIcons.shoppingCart, "Compras", 14, 145.12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        }, itemCount: 10,
      ),
    );
  }

  String getMonthName(int index) {
    switch (index) {
      case 0:
        return 'Enero';
      case 1:
        return 'Febrero';
      case 2:
        return 'Marzo';
      case 3:
        return 'Abril';
      case 4:
        return 'Mayo';
      case 5:
        return 'Junio';
      case 6:
        return 'Julio';
      case 7:
        return 'Agosto';
      case 8:
        return 'Septiembre';
      case 9:
        return 'Octubre';
      case 10:
        return 'Noviembre';
      case 11:
        return 'Diciembre';
      default:
        return '';
    }
  }


}


