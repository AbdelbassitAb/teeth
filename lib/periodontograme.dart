import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:get/get.dart';
import 'dialogsController.dart';
class Periodontograme extends StatefulWidget {
  @override
  _PeriodontogrameState createState() => _PeriodontogrameState();
}

class _PeriodontogrameState extends State<Periodontograme> {
  bool bleeding;
  bool furcation;
  bool mobility;
  bool probing;
  bool all;

  @override
  void initState() {
    bleeding = false;
    furcation = false;
    mobility = false;
    probing = false;
    all = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Periodontograme'),
          centerTitle: true,
        ),
        body: Center(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    color: all ? Colors.yellow : Colors.grey,
                    child: Text('All'),
                    onPressed: () {
                      setState(() {
                        if (all) {
                          bleeding = false;
                          furcation = false;
                          mobility = false;
                          probing = false;
                          all = false;
                        } else {
                          bleeding = true;
                          furcation = true;
                          mobility = true;
                          probing = true;
                          all = true;
                        }
                      });
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    RaisedButton(
                        color: bleeding ? Colors.red : Colors.grey,
                        child: Text('Bleeding'),
                        onPressed: () {
                          setState(() {
                            bleeding = !bleeding;
                          });
                        }),
                    RaisedButton(
                        color: furcation ? Colors.pink : Colors.grey,
                        child: Text('Furcation'),
                        onPressed: () {
                          setState(() {
                            furcation = !furcation;
                          });
                        }),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 65,
                    ),
                    RaisedButton(
                        color: mobility ? Colors.green : Colors.grey,
                        child: Text('mobility'),
                        onPressed: () {
                          setState(() {
                            mobility = !mobility;
                          });
                        }),
                    RaisedButton(
                        color: probing ? Colors.blue : Colors.grey,
                        child: Text('Probing Depth'),
                        onPressed: () {
                          setState(() {
                            probing = !probing;
                          });
                        }),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  color: Colors.redAccent[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Teeth('assets/r13.svg', 'assets/13.svg', bleeding,
                          furcation, mobility),
                      Teeth('assets/r12.svg', 'assets/12.svg', bleeding,
                          furcation, mobility),
                      Teeth('assets/r11.svg', 'assets/11.svg', bleeding,
                          furcation, mobility),
                      Teeth('assets/r21.svg', 'assets/21.svg', bleeding,
                          furcation, mobility),
                      Teeth('assets/r22.svg', 'assets/22.svg', bleeding,
                          furcation, mobility),
                      Teeth('assets/r23.svg', 'assets/23.svg', bleeding,
                          furcation, mobility),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class Teeth extends StatefulWidget {
  final String racine;
  final String teeth;
  final bool bleedingState;
  final bool furcationState;
  final bool mobilityState;

  Teeth(
    this.racine,
    this.teeth,
    this.bleedingState,
    this.furcationState,
    this.mobilityState,
  );

  @override
  _TeethState createState() => _TeethState();
}

class _TeethState extends State<Teeth> {

  final DialogsController dialogsController = Get.put(DialogsController());
  GlobalKey _key = GlobalKey();
  GlobalKey _key2 = GlobalKey();
  Info info;
  Bleeding bleeding;
  double widthTeeth = 0;
  double heightRacine = 0;
  double widthRacine = 0;
  double x = 0;
  double y = 0;

  _getSizes() {
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    final size = renderBoxRed.size;
    final RenderBox renderBoxRed2 = _key2.currentContext.findRenderObject();
    final size2 = renderBoxRed2.size;
    widthTeeth = size2.width;
    heightRacine = size.height;
    widthRacine = size.width;
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    super.initState();



    info = Info(
      this.widget.teeth,
      this.widget.racine,
      0,
      0,
      bleeding = Bleeding(false, false, false),
    );
  }

  _getPositions() {
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    final position = renderBoxRed.localToGlobal(Offset.zero);
    x = position.dx;
    y = position.dy;
  }

  @override
  @override
  Widget build(BuildContext context) {

    Future<void> _showMyDialog(Info info) async {

      dialogsController.left(info.bleeding.left);
      dialogsController.right(info.bleeding.right);
      dialogsController.center(info.bleeding.center);
      dialogsController.mobilityVal(info.mobilityVal);
      dialogsController.furcationVal(info.furcationVal);


      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content:  GetX<DialogsController>(
              builder: (dialogsController) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListBody(
                    children: <Widget>[




                      NumberPicker.integer(
                          initialValue: dialogsController.mobilityVal.value,
                          minValue: 0,
                          maxValue: 4,

                          onChanged: (newValue) => dialogsController.mobilityVal(newValue)    )               ,
                      NumberPicker.integer(
                          initialValue: dialogsController.furcationVal.value,
                          minValue: 0,
                          maxValue: 4,
                          onChanged: (newValue) =>
                              dialogsController.furcationVal(newValue)),


                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              color: dialogsController.left.value ? Colors.red : Colors.grey,
                              onPressed: () {
                                dialogsController.left(!dialogsController.left.value);
                               
                              },
                              child: Text('Left'),
                            ),
                            RaisedButton(
                              color:
                                 dialogsController.center.value ? Colors.red : Colors.grey,
                              onPressed: () {
                               dialogsController.center(!dialogsController.center.value);
                              },
                              child: Text('Center'),
                            ),
                            RaisedButton(
                              color: dialogsController.right.value ? Colors.red : Colors.grey,
                              onPressed: () {
                                                          dialogsController.right(!dialogsController.right.value);

                              },
                              child: Text('Right'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Approve'),
                onPressed: () {
                  setState(() {

                    info.mobilityVal=dialogsController.mobilityVal.value;
                    info.furcationVal=dialogsController.furcationVal.value;
                    info.bleeding.left= dialogsController.left.value;
                    info.bleeding.center= dialogsController.center.value;
                    info.bleeding.right= dialogsController.right.value;
                  });

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
        setState(() {
          _getSizes();
        });
        print('$x   $y   $heightRacine    $widthTeeth');
        _showMyDialog(info);
      },
      child: Stack(children: [
        Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  info.racine,
                  color: Colors.white,
                  key: _key,
                ),
              ],
            ),
            SvgPicture.asset(
              info.teeth,
              color: Colors.white,
              key: _key2,
            ),
          ],
        ),
        Stack(
          children: [
            this.widget.mobilityState
                ? Container(
                    width: widthTeeth / 8 * info.mobilityVal,
                    height: widthTeeth / 8 * info.mobilityVal,
                    child: CustomPaint(
                      painter: OpenPainter(
                          x,
                          y,
                          heightRacine,
                          widthTeeth / 2,
                          widthRacine,
                          Colors.green,
                          info.mobilityVal,
                          PaintingStyle.fill),
                    ),
                  )
                : SizedBox(),
            this.widget.furcationState
                ? Container(
                    width: widthTeeth / 8 * info.furcationVal,
                    height: widthTeeth / 8 * info.furcationVal,
                    child: CustomPaint(
                      painter: OpenPainter(
                          x,
                          y,
                          heightRacine / 2,
                          widthTeeth / 2,
                          widthRacine,
                          Colors.pink,
                          info.furcationVal,
                          PaintingStyle.stroke),
                    ),
                  )
                : SizedBox(),
            (info.bleeding.left && this.widget.bleedingState)
                ? Container(
                    width: widthTeeth / 8,
                    height: widthTeeth / 8,
                    child: CustomPaint(
                      painter: OpenPainter(
                          x,
                          y,
                          heightRacine,
                          (widthTeeth - widthRacine) / 2,
                          widthRacine,
                          Colors.red,
                          1,
                          PaintingStyle.fill),
                    ),
                  )
                : SizedBox(),
            (info.bleeding.center && this.widget.bleedingState)
                ? Container(
                    width: widthTeeth / 8,
                    height: widthTeeth / 8,
                    child: CustomPaint(
                      painter: OpenPainter(x, y, heightRacine, widthTeeth / 2,
                          widthRacine, Colors.red, 1, PaintingStyle.fill),
                    ),
                  )
                : SizedBox(),
            (info.bleeding.right && this.widget.bleedingState)
                ? Container(
                    width: widthTeeth / 8,
                    height: widthTeeth / 8,
                    child: CustomPaint(
                      painter: OpenPainter(
                          x,
                          y,
                          heightRacine,
                          (widthTeeth + widthRacine) / 2,
                          widthRacine,
                          Colors.red,
                          1,
                          PaintingStyle.fill),
                    ),
                  )
                : SizedBox(),
          ],
        )
      ]),
    );
  }
}

class Info {
  String teeth;
  String racine;
  int mobilityVal;
  int furcationVal;
  Bleeding bleeding;

  Info(
    this.teeth,
    this.racine,
    this.mobilityVal,
    this.furcationVal,
    this.bleeding,
  );
}

class Bleeding {
  bool left;
  bool center;
  bool right;

  Bleeding(this.left, this.center, this.right);
}

class OpenPainter extends CustomPainter {
  final double x;
  final double y;
  final double height;
  final double widthTeeth;
  final double widthRacine;
  final int radius;
  PaintingStyle style;

  final Color color;

  OpenPainter(this.x, this.y, this.height, this.widthTeeth, this.widthRacine,
      this.color, this.radius, this.style);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = style
      ..strokeWidth = (radius == 0) ? 0 : 2;
    //a circle
    canvas.drawCircle(
        Offset(widthTeeth, height * 0.9), widthRacine / 8 * radius, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


