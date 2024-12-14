import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playbook/screens/home.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //important
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DataBaseProvider(),
        child: MaterialApp(
          title: 'Playbook',
          theme: ThemeData(
            fontFamily: GoogleFonts.lexend().fontFamily,
            useMaterial3: true,
          ),
          home: const Home(),
        ));
  }
}
