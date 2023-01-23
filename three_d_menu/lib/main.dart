import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);


  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  late Size size;
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
     _animationController = AnimationController(vsync: this,
         duration: const Duration(milliseconds: 500));
     _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
     WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Container(
        color: Colors.green,
        child: Stack(
          children: [
            Container(
              //color: Colors.white,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.grey
                      ],
                      stops: [0.65,1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  )
              ),
            ),
            Container(
              width: size.width/2,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Column(
                    // mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       const DrawerHeader(
                           child: CircleAvatar(
                             radius: 50,
                             backgroundImage: AssetImage("assets/images/flutter.png",

                             ),),),
                       Text("Flutter",
                         style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white
                            ),
                       )
                     ],
                   ),
                   Expanded(child: ListView(
                       children: const [
                         ListTile(
                           leading:Icon(
                             FontAwesomeIcons.github,
                             color: Colors.white,
                           ),
                           title: Text(
                             "Github",
                              style: TextStyle(color: Colors.white),
                           ),
                         ),
                         ListTile(
                           leading:Icon(
                             FontAwesomeIcons.linkedin,
                             color: Colors.white,
                           ),
                           title: Text(
                             "Linkedin",
                             style: TextStyle(color: Colors.white),
                           ),
                         ),
                         ListTile(
                           leading:Icon(
                             FontAwesomeIcons.twitter,
                             color: Colors.white,
                           ),
                           title: Text(
                             "Twitter",
                             style: TextStyle(color: Colors.white),
                           ),
                         ),
                         ListTile(
                           leading:Icon(
                             FontAwesomeIcons.facebook,
                             color: Colors.white,
                           ),
                           title: Text(
                             "Facebook",
                             style: TextStyle(color: Colors.white),
                           ),
                         ),

                       ],
                   ))

                ],
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context,child){
                return Transform(
                    transform: Matrix4
                    .identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, (size.width/2)*_animation.value)
                  ..rotateY((pi/6)*_animation.value),
                alignment: Alignment.centerRight,
                child: child,
                );
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(onPressed:(){
                    if(_animationController.isDismissed)
                    {
                      // _animationController.reset();
                      _animationController.forward();
                    }
                    else if(_animationController.isCompleted)
                    {
                      //  _animationController.reset();
                      _animationController.reverse();
                    }
                  }, icon: const Icon(Icons.menu)),
                  elevation: 0,
                  backgroundColor: Colors.black,
                  title: const Text("My Test"),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}

