import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

import 'selection_app_bar.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(elevation: 2),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = DragSelectGridViewController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelectionAppBar(
        selection: controller.value,
        title: const Text('Grid Example2'),
      ),
      body: Stack(
        children: [
          DragSelectGridView(
            gridController: controller,
            padding: const EdgeInsets.all(8),
            itemCount: 90,
            itemBuilder: (context, index, selected) {
              return SelectableItem(
                index: index,
                color: Colors.blue,
                selected: selected,
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Inner(controller: controller),
          )
        ],
      ),
    );
  }

  void scheduleRebuild() => setState(() {});
}

class Inner extends StatelessWidget {
  const Inner({
    super.key,
    required this.controller,
  });

  final DragSelectGridViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: 50,
          width: 390,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '選択中 ${controller.value.amount} 件',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.folder,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  color: Colors.white,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text(
                                          '選択したファイルをグループに追加しますか？',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '選択した${controller.value.amount}件をグループに追加しますか？',
                                        ),
                                        ElevatedButton(
                                          child: const Text('はい'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              context: context);
                        },
                      ),
                      const Icon(
                        Icons.folder,
                        color: Colors.blue,
                      ),
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
