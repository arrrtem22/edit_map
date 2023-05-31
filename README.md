# Edit Map

[![pub package](https://img.shields.io/pub/v/edit_map.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/edit_map)
[![Last Commits](https://img.shields.io/github/last-commit/arrrtem22/edit_map?logo=git&logoColor=white)](https://github.com/arrrtem22/edit_map/commits/master)
[![Pull Requests](https://img.shields.io/github/issues-pr/arrrtem22/edit_map?logo=github&logoColor=white)](https://github.com/arrrtem22/edit_map/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/arrrtem22/edit_map?logo=github&logoColor=white)](https://github.com/arrrtem22/edit_map)
[![License](https://img.shields.io/github/license/arrrtem22/edit_map?logo=open-source-initiative&logoColor=green)](https://github.com/arrrtem22/edit_map/blob/master/LICENSE)

The map that allows users to interact with various 2-dimensional shapes.<br>
Inspired by [FlutterGallery 2D Transformations](https://github.com/flutter/gallery/blob/6fa29dc0d1ba496b6858b07c4465757e2025f548/lib/demos/reference/transformations_demo.dart).

**Show some ❤️ and star the repo to support the project**

### Resources:
- [Pub Package](https://pub.dev/packages/edit_map)
- [GitHub Repository](https://github.com/arrrtem22/edit_map)

## Getting Started

Just import `EditMap` widget and start interacting:
```dart

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
            if (kDebugMode) {
              print(
                  '---desk moved---\nx:${deskPosition.dx}\ny:${deskPosition.dy}');
            }
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
```

Feel free to open pull requests.

# Acknowledgments

This package was originally created by [Artemii Oliinyk](https://github.com/arrrtem22).