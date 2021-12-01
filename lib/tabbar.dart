import 'package:flutter/material.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({Key? key}) : super(key: key);

  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  @override
  void initState() {
    // printLog("[Dashboard] init");
    // if (!kIsWeb) {
    //   getCurrentUser();
    // }
    // setupListenEvent();
    // MainTabControlDelegate.getInstance().changeTab = changeTab;
    // MainTabControlDelegate.getInstance().tabAnimateTo = (int index) {
    //   tabController?.animateTo(index);
    // };
    // Future.delayed(const Duration(seconds: 2), () {
    //   tabController.addListener(_handleTabChange);
    // }); // เพิ่มเอง

    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // tabController?.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    // _subOpenNativeDrawer?.cancel();
    // _subCloseNativeDrawer?.cancel();
    // _subOpenCustomDrawer?.cancel();
    // _subCloseCustomDrawer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
