import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  List<String> listNames = [];
  StreamController<List> streamController = StreamController();

  void onTapAdd() {
    if (nameTextEditingController.text.isNotEmpty) {
      listNames.add(nameTextEditingController.text);
      streamController.sink.add(listNames);
      nameTextEditingController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive career Example'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: listNames.length,
                      itemBuilder: (context, index) => Text(
                        listNames[index],
                      ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: listNames.length,
            //     itemBuilder: (context, index) => Text(
            //       listNames[index],
            //     ),
            //   ),
            // ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: nameTextEditingController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) => onTapAdd(),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => onTapAdd(),
                    child: const Text('Add'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
