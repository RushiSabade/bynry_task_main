import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.dashboard),
          onPressed: () {},
        ),

        IconButton(onPressed: (){}, icon: Icon(Icons.person)),
        IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
      ],
    ));
  }
}
