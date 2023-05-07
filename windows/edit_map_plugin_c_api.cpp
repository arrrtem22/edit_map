#include "include/edit_map/edit_map_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "edit_map_plugin.h"

void EditMapPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  edit_map::EditMapPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
