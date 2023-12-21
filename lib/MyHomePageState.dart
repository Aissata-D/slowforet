import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:slowforet/MyHomePage.dart';
import 'firebase_options.dart';

class MyHomePageState extends State<MyHomePage> {
  int _counter = 10;

  void _authFirebase() async {

    //WidgetsFlutterBinding.ensureInitialized();
    //await Firebase.initializeApp();
    log("debut");

    //Future<void> main() async {
    // WidgetsFlutterBinding.ensureInitialized();
    //  await Firebase.initializeApp();
    // log("future");

// Ideal time to initialize
    // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
//...
    //}


    FirebaseAuth.instance
    //.idTokenChanges()
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    // }
  }

  Future<UserCredential> signInWithGoogle() async {
    log("signInWithGoogle");
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,


          children: <Widget>[
            Image.asset('images/logo_acceuil.png'),
            SizedBox(
              height: 200,
            ),

            new SizedBox(
              width: 310.0,
              //height: 100.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.75),

                    // textStyle: const TextStyle(color: Colors.black)
                  ),
                  onPressed: signInWithGoogle,
                  // child: Image.asset('images/bouton_google.png')
                  child: Text('Se connecter',
                      style: TextStyle(color: Colors.black, fontSize: 20))
              ),
            ),
            SizedBox(
              height: 20,
            ),

            new SizedBox(
                width: 310.0,
                //height: 100.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,

                      // textStyle: const TextStyle(color: Colors.black)
                    ),
                    onPressed: signInWithGoogle,
                    // child: Image.asset('images/bouton_google.png')
                    child: Text('Inscrivez-vous',
                        style: TextStyle(color: Colors.white, fontSize: 20))
                )
            ),
            SizedBox(
              height: 20,
            ),
            Text('OU',
                style: TextStyle(color: Colors.white, fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),

            new SizedBox(
                width: 310.0,
                //height: 100.0,
                child: ElevatedButton.icon(

                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,

                      // textStyle: const TextStyle(color: Colors.black)
                    ),

                    icon:Image.asset('images/icon_google.png',
                        width: 25), //icon data for elevated button
                    label: Text("Continuer avec Google",
                        style: TextStyle(color: Colors.white, fontSize: 20)), //label text
                    onPressed: signInWithGoogle,
                    // child: Image.asset('images/bouton_google.png')

                )
            ),
            SizedBox(
              height: 20,
            ),

            new SizedBox(
                width: 310.0,
                //height: 100.0,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,

                      // textStyle: const TextStyle(color: Colors.black)
                    ),
                    icon:Image.asset('images/icon_facebook.png',
                      width: 25),  //icon data for elevated button
                    label: Text("Continuer avec Facebook",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: signInWithGoogle,
                    // child: Image.asset('images/bouton_google.png')

                )
            ),
          ],

        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}