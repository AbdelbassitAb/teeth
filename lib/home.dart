import 'package:flutter/material.dart';
import 'package:teeth/periodontograme.dart';
import 'package:teeth/teeth_chart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeethChart()),
                    );
                  },
                  child: Text('Teeth chart'),
                ),

                SizedBox(width: 50,),

                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Periodontograme()),
                    );
                  },
                  child: Text('Periodotograme'),
                )
              ],
            ),
          ),
        ));
  }
}
