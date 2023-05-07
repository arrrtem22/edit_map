//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <edit_map/edit_map_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) edit_map_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "EditMapPlugin");
  edit_map_plugin_register_with_registrar(edit_map_registrar);
}
