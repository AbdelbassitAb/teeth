import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class TeethChart extends StatefulWidget {
  TeethChart({
    Key key,
  }) : super(key: key);

  @override
  _TeethChartState createState() => _TeethChartState();
}

class _TeethChartState extends State<TeethChart> {
  int _counter = 0;

  String path = 'assets/12.svg';

  final String assetName = "assets/r12.svg";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget svgIcon = SvgPicture.asset(assetName,
        color: Colors.red, semanticsLabel: 'A red up arrow');

    return Scaffold(
      appBar: AppBar(
        title: Text('tooth chart'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.redAccent[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Teeth('assets/r13.svg', 'assets/13.svg', 'assets/r53.svg',
                      'assets/53.svg'),
                  Teeth('assets/r12.svg', 'assets/12.svg', 'assets/r52.svg',
                      'assets/52.svg'),
                  Teeth('assets/r11.svg', 'assets/11.svg', 'assets/r51.svg',
                      'assets/51.svg'),
                  Teeth('assets/r21.svg', 'assets/21.svg', 'assets/r13.svg',
                      'assets/13.svg'),
                  Teeth('assets/r22.svg', 'assets/22.svg', 'assets/r13.svg',
                      'assets/13.svg'),
                  Teeth('assets/r23.svg', 'assets/23.svg', 'assets/r13.svg',
                      'assets/13.svg'),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Teeth extends StatefulWidget {
  final String racine;
  final String teeth;
  final String racine2;
  final String teeth2;

  Teeth(this.racine, this.teeth, this.racine2, this.teeth2);

  @override
  _TeethState createState() => _TeethState();
}

class _TeethState extends State<Teeth> {
  Info info;

  @override
  void initState() {
    info = Info(
        false,
        false,
        this.widget.teeth,
        this.widget.racine,
        this.widget.teeth2,
        this.widget.racine2,
        Colors.white,
        Colors.white);

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    List<Couleur> colors = new List<Couleur>(7);

    colors[0] = new Couleur(Colors.transparent, "Transaprant");
    colors[1] = new Couleur(Colors.white, "White");
    colors[2] = new Couleur(Colors.red, "Rouge");
    colors[3] = new Couleur(Colors.blue, "Bleu");
    colors[4] = new Couleur(Colors.black, "Noire");
    colors[5] = new Couleur(Colors.yellow, "Jaune");
    colors[6] = new Couleur(Colors.green, "Vert");


    Future<void> _modifier(Info info) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return Expanded(
            child: AlertDialog(
              title: Text('AlertDialog Title'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Teeth color'),
                    DropdownButtonFormField(
                      value: info.teethCol != null ? info.teethCol : null,
                      decoration: textInputDecoration,
                      items: colors.map((color) {
                        return DropdownMenuItem(
                          value: color.color,
                          child: Text(color.name, style: TextStyle(
                              color: (color.color == Colors.white ||
                                  color.color == Colors.transparent) ? Colors
                                  .black : color.color),),
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() {
                            info.teethCol = val;
                          }),
                    ),
                    Text('Racine Color'),
                    DropdownButtonFormField(
                      value: info.racineCole != null ? info.racineCole : null,
                      decoration: textInputDecoration,
                      items: colors.map((color) {
                        return DropdownMenuItem(
                          value: color.color,
                          child: Text(color.name, style: TextStyle(
                              color: (color.color == Colors.white ||
                                  color.color == Colors.transparent) ? Colors
                                  .black : color.color),),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => info.racineCole = val),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> _showMyDialog(Info info) async {
      String temp;
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: Colors.grey,
                        child: Center(child: Text('11')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  info.deleted = !info.deleted;
                                  Navigator.pop(context);
                                });
                              }),
                          IconButton(
                              icon: Icon(Icons.wifi_protected_setup_outlined),
                              onPressed: () {
                                setState(() {
                                  temp = info.racine;
                                  info.racine = info.racine2;
                                  info.racine2 = temp;
                                  temp = info.teeth;
                                  info.teeth = info.teeth2;
                                  info.teeth2 = temp;
                                  Navigator.pop(context);
                                });
                              }),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _modifier(info);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  info.toExtract = !info.toExtract;
                                  Navigator.pop(context);
                                });
                              }),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        _showMyDialog(info);
      },
      child: Column(
        children: [


          AnimatedCrossFade(
              firstChild: Icon(
            Icons.clear,
          ),
              secondChild: AnimatedCrossFade(
                duration: Duration(milliseconds: 800),
                crossFadeState:  info.toExtract ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild: Icon(Icons.delete, color: Colors.red,),
                  secondChild: Column(
                    children: [
                      SvgPicture.asset(
                        info.racine,
                        color: info.racineCole,
                      ),
                      SvgPicture.asset(
                        info.teeth,
                        color: info.teethCol,
                      ),
                    ],
                  ),

              ),
              crossFadeState: info.deleted ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 800)),

/*
          info.deleted
              ? Icon(
            Icons.clear,
          )
              : info.toExtract
              ? Icon(Icons.delete, color: Colors.red,)
              : Column(
            children: [
              SvgPicture.asset(
                info.racine,
                color: info.racineCole,
              ),
              SvgPicture.asset(
                info.teeth,
                color: info.teethCol,
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}

class Info {
  bool deleted;
  bool toExtract;
  String teeth;
  String racine;
  String teeth2;
  String racine2;
  Color teethCol;
  Color racineCole;

  Info(this.deleted, this.toExtract, this.teeth, this.racine, this.teeth2,
      this.racine2,
      this.teethCol, this.racineCole);

  String getTeeth() {
    return this.teeth;
  }

  String getRacine() {
    return this.racine;
  }

  String getTeeth2() {
    return this.teeth2;
  }

  String getRacine2() {
    return this.racine2;
  }

  bool getDeleted() {
    return this.deleted;
  }
}

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);


class Couleur {
  Color color;
  String name;

  Couleur(this.color, this.name);
}