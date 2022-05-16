import 'package:flutter/material.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/modal/userdatamodal.dart';

class Firbasedatafetch extends StatefulWidget {
  const Firbasedatafetch({Key? key}) : super(key: key);

  @override
  State<Firbasedatafetch> createState() => _FirbasedatafetchState();
}

class _FirbasedatafetchState extends State<Firbasedatafetch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirbaseServices().fetchdatausingfirebase();
  }

//fetching data
  Future<List<Usermodal>?> fetchdatafromfirebase() async {
    List<Usermodal>? data = await FirbaseServices().fetchdatausingfirebase();
    print("fetchdata${data?[0].email}");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Firbase collection"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder(
                  future: fetchdatafromfirebase(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                              strokeWidth: 1,
                            ),
                          ));
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                          '${snapshot.data[index].name}',
                                          // style: TextStyle(color: kPrimaryDark),
                                        ),
                                        subtitle: Text(
                                            '${snapshot.data[index].phone}'),
                                        leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            // child: Image.asset(
                                            //   "${snapshot.data[index].image}",
                                            // ),
                                            child: Text(
                                              '${snapshot.data[index].name?.substring(0, 1)}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )),
                                        onTap: () => {})
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
