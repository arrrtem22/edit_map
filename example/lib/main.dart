import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edit_map/edit_map.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<File> _loadImage() async {
    Response response = await Dio().get(
      'https://firebasestorage.googleapis.com/v0/b/workplacer-1deda.appspot.com/o/data%2Fuser%2F0%2Fhash.apps.workplacer%2Fcache%2Fimage_picker4792814428577454194.png?alt=media&token=aca939cc-28fa-4f9e-abfb-be3bd3e2a933',
      options: Options(responseType: ResponseType.bytes),
    );
    final tempDirectory = await getTemporaryDirectory();
    final file = File('${tempDirectory.path}/office-plan.jgp');
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(),
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.data != null && snapshot.hasData) {
          return _MyHomeView(mapImageFile: snapshot.data!);
        }
        return const Center(
          child: CircularProgressIndicator(
              // valueColor: AlwaysStoppedAnimation<Color>(),
              ),
        );
      },
    );
  }
}

class _MyHomeView extends StatefulWidget {
  const _MyHomeView({Key? key, required this.mapImageFile}) : super(key: key);

  final File mapImageFile;

  @override
  State<_MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<_MyHomeView> {
  bool isDraggableDeskShown = false;
  List<DeskPayload> desks = [];
  DeskPayload? lastModifiedObject;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                if (lastModifiedObject != null) {
                  desks = desks.toList()..add(lastModifiedObject!);
                  lastModifiedObject = null;
                }
                isDraggableDeskShown = false;
              });
            },
            child: const Center(
              child: Text('Save'),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isDraggableDeskShown = true;
              });
            },
            child: const AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: Text(
                  '+',
                  style: TextStyle(color: Colors.white, fontSize: 34),
                ),
              ),
            ),
          )
        ],
      ),
      body: SizedBox.expand(
        child: EditMap(
          isEditMode: true,
          mapImage: widget.mapImageFile,
          deskParamsList: desks,
          selectedDesk: isDraggableDeskShown
              ? DeskPayload(deskParams: const DeskParams(id: '1'))
              : null,
          onDeskMoved: (Offset deskPosition) {
            print(
                '---desk moved---\nx:${deskPosition.dx}\ny:${deskPosition.dy}');
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              setState(() {
                lastModifiedObject = DeskPayload(
                  deskParams: DeskParams(
                    id: (++index).toString(),
                    area: Area(position: deskPosition),
                  ),
                );
              });
            });
          },
        ),
      ),
    );
  }
}
