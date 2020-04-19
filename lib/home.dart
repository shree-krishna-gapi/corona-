import 'package:flutter/material.dart';
import 'utils/fadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'service.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading;
  Widget build(BuildContext context) {
    return Scaffold(
//      decoration: new BoxDecoration(
//        gradient: new LinearGradient(colors: [const Color(0xFF915FB5),const Color(0xFFCA436B)],
//            begin: FractionalOffset.topLeft,
//            end: FractionalOffset.bottomRight,
//            stops: [0.0,1.0],
//            tileMode: TileMode.clamp
//        ),
//      ),
      body: Container(
        decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [const Color(0xFF915FB5),const Color(0xFFCA436B)],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
        ),
      ),
        child:  FadeAnimation(
          0.5, Container(
          child: FutureBuilder<List<AllCountry>>(
              future: fetchAllCountry(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError);
                return snapshot.hasData ?
                ListView.builder(
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    itemBuilder: (context, index) {
                      return FadeAnimation(
                        0.6, Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(color: Colors.black12,
                          height: 80,

                          child: Row(
                            children: <Widget>[
                              Expanded(child: Container(
                                height: double.infinity,
                                color:Colors.black26,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Align(
                                        child: Text('${snapshot.data[index].country}',style: TextStyle(color: Colors.brown[100],
                                            fontSize: 16)),alignment: Alignment.center,
                                      ),
                                      Text('SN ${index+1}',style: TextStyle(color: Colors.orange[100],fontSize: 11))
                                    ],
                                  ),
                                ),
                              ),flex: 2,),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text('Confirmed',style: TextStyle(color: Colors.yellow[200]),),
                                        Text('Deaths',style: TextStyle(color: Colors.red[200])),
                                        Text('Criticial',style: TextStyle(color: Colors.orange[200])),
                                        Text('R',style: TextStyle(color: Colors.green[200])),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text('    ${snapshot.data[index].confirmed}',style: TextStyle(color: Colors.yellow[200])),
                                        Text('      ${snapshot.data[index].deaths}',style: TextStyle(color: Colors.red[200])),
                                        Text('       ${snapshot.data[index].critical}',style: TextStyle(color: Colors.orange[200])),
                                        Text('     ${snapshot.data[index].recovered}',style: TextStyle(color: Colors.green[200])     ),

                                      ],
                                    )
                                  ],
                                ),
                              )

                                ,flex: 4,)
                            ],
                          ),

                        ),
                      ),
                      );
                    }
                ) : Loader();
              }),
        ),
        )
      ),
    );
  }
}
