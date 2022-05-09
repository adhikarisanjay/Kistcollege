import 'package:flutter/material.dart';
import 'package:kist/Services/Apiconnectservices.dart';

class SampleJSonPage extends StatefulWidget {
  const SampleJSonPage({Key? key}) : super(key: key);

  @override
  State<SampleJSonPage> createState() => _SampleJSonPageState();
}

class _SampleJSonPageState extends State<SampleJSonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sample Json Page")),
      body: FutureBuilder(
          future: ApiConnectService().fetchSamplejson(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 1,
              );
            } else if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("${snapshot.data.name}"),
                    ),
                    Container(
                      child: Text("${snapshot.data.category}"),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Column(children: const [Text("This is empty column")]);
            }
          }),
    );
  }
}
