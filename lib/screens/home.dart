import 'package:flutter/material.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/widgets/buttons/exit_button.dart';
import 'package:playbook/widgets/buttons/home_page_init_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Playbook'),
            Image.asset('assets/bafik.png', width: 80, height: 80),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 125, 186, 3),
      ),
      body: Consumer<DataBaseProvider>(
        builder: (context, value, child) => Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            fit: StackFit.loose,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HomePageInitButton(type: 'Insert'),
                      SizedBox(
                        width: 50,
                      ),
                      HomePageInitButton(type: 'Read'),
                    ],
                  ),
                ],
              ),
              const Positioned(
                bottom: 30,
                right: 15,
                child: ExitButton(),
              ),
              Positioned(
                bottom: 0,
                right: 15,
                child: Image.asset('assets/bafik.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
