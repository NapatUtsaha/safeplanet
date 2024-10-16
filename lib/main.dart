import 'package:flutter/material.dart';
import 'package:safeplanet_new/calchoose.dart';
import 'package:safeplanet_new/calh1.dart';
import 'package:safeplanet_new/calhTime.dart';
import 'package:safeplanet_new/calhome.dart';
import 'package:safeplanet_new/calhome2.dart';
import 'package:safeplanet_new/calhome3.dart';
import 'package:safeplanet_new/calhome4.dart';
import 'package:safeplanet_new/car.dart';
import 'package:safeplanet_new/carResult.dart';
import 'package:safeplanet_new/carResult2.dart';
import 'package:safeplanet_new/carch.dart';
import 'package:safeplanet_new/loResult.dart';
import 'package:safeplanet_new/local1.dart';
import 'package:safeplanet_new/local2.dart';
import 'package:safeplanet_new/local3.dart';
import 'package:safeplanet_new/local4.dart';
import 'package:safeplanet_new/localh.dart';
import 'package:safeplanet_new/localhTime.dart';
import 'package:safeplanet_new/location.dart';
import 'package:safeplanet_new/saveLocation.dart';
import 'package:safeplanet_new/saveResultCar.dart';
import 'package:safeplanet_new/saveResultTree.dart';
import 'locationch.dart';
import 'package:safeplanet_new/result.dart';
import 'package:safeplanet_new/saveResult.dart';
import 'package:safeplanet_new/tree1.dart';
import 'package:safeplanet_new/treeResult.dart';
import 'login.dart';
import 'home.dart';
import 'register.dart';
import 'cal1.dart';
import 'result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: login(),
      routes: {
        'register': (context) => register(),
        'home': (context) => Homepage(),
        'login': (context) => login(),
        'cal1': (context) => cal1(),
        'saveLocation': (context) => saveLocation(),
        'location': (context) => location(),
        'calch': (context) => calch(),
        'calh1': (context) => calh1(),
        'calhTime': (context) => calhTime(),
        'calhome': (context) => calhome(),
        'calhome2': (context) => calhome2(),
        'calhome3': (context) => calhome3(),
        'calhome4': (context) => calhome4(),
        'result': (context) => result(),
        'car': (context) => car(),
        'carch': (context) => carch(),
        'carResult': (context) => carResult(),
        'carResult2': (context) => carResult2(),
        'tree': (context) => tree(),
        'treeResult': (context) => treeResult(),
      },
      onGenerateRoute: (settings) {
        // ตรวจสอบชื่อเส้นทาง
        if (settings.name == 'saveResult') {
          final int id = settings.arguments as int; // แปลง arguments
          return MaterialPageRoute(
            builder: (context) {
              return SaveResultPage(id: id); // ส่งค่าที่ดึงมาให้กับหน้าต่อไป
            },
          );
        }
         if (settings.name == 'saveResultTree') {
          final int id_t = settings.arguments as int; // แปลง arguments
          return MaterialPageRoute(
            builder: (context) {
              return saveResultTree(id_t: id_t); // ส่งค่าที่ดึงมาให้กับหน้าต่อไป
            },
          );
        }
        if (settings.name == 'saveResultCar') {
          final int id_c = settings.arguments as int; // แปลง arguments
          return MaterialPageRoute(
            builder: (context) {
              return saveResultCar(id_c: id_c); // ส่งค่าที่ดึงมาให้กับหน้าต่อไป
            },
          );
        }
        if (settings.name == 'locationch') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('Received Email: $email');
            return MaterialPageRoute(
              builder: (context) {
                return locationch(
                    location: location,
                    email: email); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        if (settings.name == 'local1') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('Received Email: $email');
            return MaterialPageRoute(
              builder: (context) {
                return local1(
                    location: location,
                    email: email); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        if (settings.name == 'local2') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email'];
            final int? id_u = args['id_u']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('ReceivedEmail: $email') ;
            print('ReceivedId_u: $id_u') ;
            return MaterialPageRoute(
              builder: (context) {
                return local2(
                    location: location,
                    email: email,
                    id_u: id_u,); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        if (settings.name == 'local3') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email'];
            final int? id_u = args['id_u']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('ReceivedEmail: $email') ;
            print('ReceivedId_u: $id_u') ;
            return MaterialPageRoute(
              builder: (context) {
                return local3(
                    location: location,
                    email: email,
                    id_u: id_u,); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        if (settings.name == 'local4') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email'];
            final int? id_u = args['id_u']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('ReceivedEmail: $email') ;
            print('ReceivedId_u: $id_u') ;
            return MaterialPageRoute(
              builder: (context) {
                return local4(
                    location: location,
                    email: email,
                    id_u: id_u,); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        if (settings.name == 'loResult') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('Received Email: $email');
            return MaterialPageRoute(
              builder: (context) {
                return loResult(
                    location: location,
                    email: email); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        if (settings.name == 'localh') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('Received Email: $email');
            return MaterialPageRoute(
              builder: (context) {
                return localh(
                    location: location,
                    email: email); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        if (settings.name == 'localhTime') {
          final Map<String, dynamic>? args = settings.arguments
              as Map<String, dynamic>?; // แปลง arguments เป็น Map
          if (args != null) {
            final String? location = args['location']; // ดึงค่า location
            final String? email = args['email']; // ดึงค่า email
            print('Received Location: $location'); // ตรวจสอบค่าที่รับมาที่นี่
            print('Received Email: $email');
            return MaterialPageRoute(
              builder: (context) {
                return localhTime(
                    location: location,
                    email: email); // ส่งค่า location และ email ไปยังหน้าต่อไป
              },
            );
          } else {
            print(
                'Arguments are null'); // ตรวจสอบว่า arguments เป็น null หรือไม่
          }
        }
        return null; // ต้องมีเพื่อป้องกันการเกิด error
      }, // ต้องมีเพื่อป้องกันการเกิด error
    );
  }
}
