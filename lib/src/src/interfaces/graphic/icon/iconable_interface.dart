import 'package:edit_map/src/src/interfaces/graphic/icon/icon_interface.dart';
import 'package:edit_map/src/src/interfaces/graphic/object_interface.dart';

abstract class IconableInterface {
  void setIcons(Params<IconInterface> icons);
  Params<IconInterface> getIcons();
  void setIcon(IconInterface icon);
}
