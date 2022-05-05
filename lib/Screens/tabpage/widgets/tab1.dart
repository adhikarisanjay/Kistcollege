import 'package:flutter/material.dart';
import 'package:kist/Screens/tabpage/constants.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: studentslist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                      title: Text(
                        '${studentslist[index].name}',
                        // style: TextStyle(color: kPrimaryDark),
                      ),
                      subtitle: Text('${studentslist[index].phone}'),
                      leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${studentslist[index].name?.substring(0, 1)}',
                            style: const TextStyle(color: Colors.white),
                          )),
                      onTap: () => {})
                ],
              ),
            );
          }),
    );
  }
}
