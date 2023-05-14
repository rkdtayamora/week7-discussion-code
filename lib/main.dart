import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:tayamora_ex8/models/slambook_model.dart';
import 'package:tayamora_ex8/providers/slambook_provider.dart';
import 'package:tayamora_ex8/screens/formfield_page.dart';
import 'package:tayamora_ex8/screens/friends_page.dart';
import 'package:tayamora_ex8/screens/frienddata_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => SlambookListProvider())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Slambook',
      initialRoute: '/',
      routes: {
        FriendsPage.routename: (context) => const FriendsPage(),
        FormFile.routename: (context) => FormFile(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == FriendData.routename) {
          final args = settings.arguments as Slambook;
          return MaterialPageRoute(builder: (context) {
            return FriendData(item: args);
          });
        }
        return null;        
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
