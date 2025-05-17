//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <geolocator_windows/geolocator_windows.h>
<<<<<<< HEAD
#include <permission_handler_windows/permission_handler_windows_plugin.h>
#include <url_launcher_windows/url_launcher_windows.h>
=======
>>>>>>> 2426dec86206fdf4c65494e8bd4946fc46682871

void RegisterPlugins(flutter::PluginRegistry* registry) {
  GeolocatorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GeolocatorWindows"));
<<<<<<< HEAD
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
=======
>>>>>>> 2426dec86206fdf4c65494e8bd4946fc46682871
}
