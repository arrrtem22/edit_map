import 'package:flutter_test/flutter_test.dart';
import 'package:edit_map/edit_map.dart';
import 'package:edit_map/edit_map_platform_interface.dart';
import 'package:edit_map/edit_map_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEditMapPlatform
    with MockPlatformInterfaceMixin
    implements EditMapPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EditMapPlatform initialPlatform = EditMapPlatform.instance;

  test('$MethodChannelEditMap is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEditMap>());
  });

  test('getPlatformVersion', () async {
    EditMap editMapPlugin = EditMap();
    MockEditMapPlatform fakePlatform = MockEditMapPlatform();
    EditMapPlatform.instance = fakePlatform;

    expect(await editMapPlugin.getPlatformVersion(), '42');
  });
}
