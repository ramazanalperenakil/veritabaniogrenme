import 'package:flutter/material.dart';
import 'package:veritabaniogrenme/NotePage.dart';
import 'package:veritabaniogrenme/UpdatePage.dart';
import 'AddNotePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue, // App bar and other primary colors
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Uygulması'),
        backgroundColor: Colors.blue, // App bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Other widgets on your main page

            // Button 1
            ElevatedButton(
              onPressed: () {
                // Navigate to AddNotePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNotePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
              ),
              child: Text('Not Ekle'),
            ),

            // Button 2
            ElevatedButton(
              onPressed: () {
                // NotePage sayfasına geçiş
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
              ),
              child: Text('Notları Görüntüle'),
            ),

            // Text
            Text(
              "Bu Uygulama Flutter Yerel Veri Tabanı Öğrenme Amaçlı Yapılmıştır.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Background color
    );
  }
}
