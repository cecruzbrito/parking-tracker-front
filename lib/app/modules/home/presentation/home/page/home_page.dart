import 'package:flutter/material.dart';

import '../store/home_page_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.store});
  final HomePageStore store;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
