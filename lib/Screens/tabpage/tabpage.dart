import 'package:flutter/material.dart';
import 'package:kist/Screens/tabpage/widgets/tab1.dart';
import 'package:kist/Screens/tabpage/widgets/tab2.dart';
import 'package:easy_localization/easy_localization.dart';

class TabBarPage extends StatefulWidget {
  final String? title;
  const TabBarPage({Key? key, this.title}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text("${widget.title}"),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: "Listview",
                    ),
                    Tab(
                      text: "tab2".tr(),
                    ),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [Tab1(), Tab2()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
