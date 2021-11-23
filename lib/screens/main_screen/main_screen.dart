import 'package:demo/keys/keys.dart';
import 'package:demo/screens/main_screen/tabs/hoenn_tab/hoenn_tab.dart';
import 'package:demo/screens/main_screen/tabs/johto_tab/johto_tab.dart';
import 'package:demo/screens/main_screen/tabs/kanto_tab/kanto_tab.dart';
import 'package:demo/screens/main_screen/tabs/sinnoh_tab/sinnoh_tab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        key: Keys.nestedScrollViewKey,
        controller: _scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // Add the app bar to the CustomScrollView.
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                // Provide a standard title.
                expandedHeight: 100,
                title: Image.asset(
                  "assets/images/logo.png",
                  height: 40,
                  filterQuality: FilterQuality.high,
                ),
                floating: true,
                pinned: true,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: "Kanto",
                    ),
                    Tab(
                      text: "Johto",
                    ),
                    Tab(
                      text: "Hoenn",
                    ),
                    Tab(
                      text: "Sinnoh",
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            KantoTab(),
            JohtoTab(),
            HoennTab(),
            SinnohTab(),
          ],
        ),
      ),
    );
  }
}
