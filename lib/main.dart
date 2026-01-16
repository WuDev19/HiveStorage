import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_storage/Person.dart';

import 'HomePage.dart';

void main() async {
  //đảm bảo flutter engine đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  //B1: khởi tạo hive flutter
  await Hive.initFlutter();
  //B2: đăng kí adapter để ghi object
  Hive.registerAdapter(PersonAdapter());
  //B3: mở box lần đầu để sau dùng chỉ cần .box
  await Hive.openBox<Person>("person");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = Hive.box<Person>("person");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Demo Hive",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.teal,
            ),
            bottomSheet: ElevatedButton(
              onPressed: () async{
                await box.clear();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Delete All", style: TextStyle(color: Colors.white)),
            ),
            body: const HomePage(),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.eighteen_mp),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.eighteen_mp),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.eighteen_mp),
                  label: "Personal",
                ),
              ],
              onTap: (value) => print(value),
            ),
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
  @override
  void dispose() async{
    // TODO: implement dispose
    super.dispose();
    await box.close();
  }
}
