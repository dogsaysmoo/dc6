var Radio = gui.Dialog.new("/sim/gui/dialogs/radios/dialog",
        "Aircraft/dc6/Systems/tranceivers.xml");
var ap_settings = gui.Dialog.new("/sim/gui/dialogs/collins-autopilot/dialog",
        "Aircraft/dc6/Systems/autopilot-dlg.xml");

gui.menuBind("radio", "dialogs.Radio.open()");
gui.menuBind("autopilot-settings", "dialogs.ap_settings.open()");
