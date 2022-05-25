import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kist/Screens/categoryhomepage/addcategories/addcategories.dart';
import 'package:kist/Screens/phoneauth.dart';
import 'package:kist/Services/storageservice.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Home"),
            GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Logout User '),
                      content: const Text('Are you sure?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                            Storage().logoutdata();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                          child: const Text('yes'),
                        ),
                      ],
                    ),
                  );
                },
                child: Icon(Icons.logout))
          ],
        ),
      ),
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
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is Categoryfetched) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.82,
                child: ListView.builder(
                    itemCount: state.categorydata.length,
                    itemBuilder: (context, index) {
                      var result =
                          state.categorydata[index].imagePath!.split(".");
                      print("result${result.last}");

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
                                      result.last == "svg"
                                          ? SvgPicture.network(
                                              "${state.categorydata[index].imagePath}",
                                              height: 50,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  "${state.categorydata[index].imagePath}",
                                              height: 50,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                      // : Image.network(
                                      //     "${state.categorydata[index].imagePath}",
                                      //     height: 50,
                                      //   ),
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
