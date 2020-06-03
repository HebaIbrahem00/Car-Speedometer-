

import 'package:flutter/material.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:segment_display/segment_display.dart' ;
import 'package:geolocator/geolocator.dart'; 
import 'dart:async';

void main() {
  runApp(
      MaterialApp(
      home:CarSpeed(),
          theme: ThemeData(
              textTheme: TextTheme(
                  bodyText1:TextStyle(fontSize: 30,fontWeight: FontWeight.bold) ,
                  bodyText2: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.green))),

      ));


}


// ignore: must_be_immutable

class CarSpeed extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CarSpeed> { //state class that we make an object from it

  int currentspeed =0;
  int time10_30 =0;
  int time30_10 =0;
  

  /*@override
  void didUpdateWidget(CarSpeed oldWidget) {
     super.didUpdateWidget(oldWidget);
    print("ya rab");
        getSpeed();
  }*/

  @override
   initState() {
  
    super.initState();
    print("init working");
    getSpeed();
    
    


  }

  @override
  Widget build(BuildContext context) { //context is the data changes
      
   
    return  Scaffold(
      appBar: AppBar(title: Text("Car Speedometer" ), centerTitle: true,backgroundColor:Colors.black,),
    body: Column(


    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [
   Center(child: Column( children: <Widget>[Text("Current Speed" ,style: Theme.of(context).textTheme.bodyText1),SevenSegmentDisplay(value: '$currentspeed',size: 8,backgroundColor: Colors.white,segmentStyle: HexSegmentStyle(enabledColor: Colors.green,disabledColor: Colors.white)),Text("Kmh",style: Theme.of(context).textTheme.bodyText1)])) ,
    Column(children: <Widget>[Text("From 10 to 30 ",style: Theme.of(context).textTheme.bodyText1) , SevenSegmentDisplay(value:"$time10_30",size: 8,backgroundColor: Colors.white,segmentStyle: HexSegmentStyle(enabledColor: Colors.green,disabledColor: Colors.white),),Text("Seconds",style: Theme.of(context).textTheme.bodyText1)]),
    Column(children: <Widget>[Text("From 30 to 10 ",style:Theme.of(context).textTheme.bodyText1) , SevenSegmentDisplay(value: "$time30_10",size:8,backgroundColor: Colors.white,segmentStyle: HexSegmentStyle(enabledColor: Colors.green,disabledColor: Colors.white)),Text("Seconds",style: Theme.of(context).textTheme.bodyText1)])]),
    );}

 /* double calculateDistance(lat1, lon1, lat2, lon2){
    double distance ;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
     return  distance= 12742 * asin(sqrt(a));

}*/



 void getSpeed() {

  print("got called");
 final Geolocator geolocator =  Geolocator() ;
 dynamic options = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

 geolocator.getPositionStream(options).listen((position) {
   print("anythin");
  dynamic speed = position.speed; // this is your speed
  print("speeeed"+ speed);
  setState(() {
  currentspeed = speed ;    
  });
});

  }



Future<void> time10To30(speed) async{
  //calculating the time vehicle takes to speed up from 10 kmh to 30 kmh
   Stopwatch stopwatch=   Stopwatch();
   
   while(true){
   if(speed==10)
   {
     stopwatch.start();
     if(speed==30){
       stopwatch.stop() ;
       break;
     }
   }

   }
   Duration time = stopwatch.elapsed;
   setState(() {
     time10_30 = time.inSeconds ;
   });
 
}

Future<void> time30To10(speed) async{
  //calculating the time vehicle takes to slow down from 30 kmh to 10 kmh
    Stopwatch stopwatch=   Stopwatch();
   while(true){
   if(speed==30)
   {
     stopwatch.start();
     if(speed==10){
       stopwatch.stop();
       break;
     }
   }

   }
   Duration time = stopwatch.elapsed;

   setState(() {
     time30_10= time.inSeconds ;
   });
  
 
   
}




}