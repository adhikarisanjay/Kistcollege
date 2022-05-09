import 'package:flutter/material.dart';
import 'package:kist/Services/Apiconnectservices.dart';

class SampleArray extends StatefulWidget {
  const SampleArray({Key? key}) : super(key: key);

  @override
  State<SampleArray> createState() => _SampleArrayState();
}

class _SampleArrayState extends State<SampleArray> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ArrayJson")),
      body: FutureBuilder(
        future: ApiConnectService().fetchSamplejsonArray(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.abc_rounded),
                      title: Text("${snapshot.data[index].name}"),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
