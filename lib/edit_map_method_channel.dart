import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'edit_map_platform_interface.dart';

/// An implementation of [EditMapPlatform] that uses method channels.
class MethodChannelEditMap extends EditMapPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('edit_map');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
