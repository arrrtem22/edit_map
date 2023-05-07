
import 'edit_map_platform_interface.dart';

class EditMap {
  Future<String?> getPlatformVersion() {
    return EditMapPlatform.instance.getPlatformVersion();
  }
}
