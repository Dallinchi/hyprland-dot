import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import "../"

BarBlock {
    property string keyboardLayout: "En"
    content: BarText {
      symbolText: `${keyboardLayout}`
    }

    Component.onCompleted: {
      Hyprland.rawEvent.connect(hyprEvent)
    }

    function hyprEvent(e) {
      var layout = e.data.split(",")[0]; 
        if (layout.includes("at-translated-set-2-keyboard")) {
        keyboardLayout = e.data.split(",").pop().slice(0, 2)
      }
    }
}

