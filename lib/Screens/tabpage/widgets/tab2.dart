import 'package:flutter/material.dart';
import 'package:kist/Screens/tabpage/constants.dart';

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(studentslist.length, (index) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "${studentslist[index].image}",
                      height: 50,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${studentslist[index].name}'),
                  ],
                ),
              ),
              color: Colors.green[500],
            );
          })),
    );
  }
}
