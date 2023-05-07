import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'edit_map_method_channel.dart';

abstract class EditMapPlatform extends PlatformInterface {
  /// Constructs a EditMapPlatform.
  EditMapPlatform() : super(token: _token);

  static final Object _token = Object();

  static EditMapPlatform _instance = MethodChannelEditMap();

  /// The default instance of [EditMapPlatform] to use.
  ///
  /// Defaults to [MethodChannelEditMap].
  static EditMapPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EditMapPlatform] when
  /// they register themselves.
  static set instance(EditMapPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
