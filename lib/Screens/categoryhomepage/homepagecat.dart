import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kist/Screens/categoryhomepage/addcategories/addcategories.dart';
import 'package:kist/cubit/category/category_cubit.dart';

class CatHomepage extends StatefulWidget {
  const CatHomepage({Key? key}) : super(key: key);

  @override
  State<CatHomepage> createState() => _CatHomepageState();
}

class _CatHomepageState extends State<CatHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CategoryAdd()));
        },
        label: const Text('Add Category'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is Categoryfetched) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: state.categorydata.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      SvgPicture.network(
                                        "${state.categorydata[index].imagePath}",
                                        height: 50,
                                      ),
                                      // Image.network(
                                      //     "${state.categorydata[index].imagePath}"),
                                      Text("Name :" +
                                          "${state.categorydata[index].title}"),
                                      Text("Description :" +
                                          "${state.categorydata[index].description}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          // ListTile(
                          //   leading: const Icon(Icons.abc_rounded),
                          //   title: Text("${snapshot.data[index].name}"),
                          // )
                        ],
                      );
                    }),
              );
            } else if (state is CategoryFetching) {
              return const CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 1,
              );
            } else {
              return Container(
                child: Text("error"),
              );
            }
          },
        ),
      ),
    );
  }
}
