import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../utils" as Utils
import "root:/"
import "../"

RowLayout {
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    property Hyprland.workspace hypr_workspaces
    Rectangle {
        id: workspaceBar
        Layout.preferredHeight: Theme.get.preferredHeight
       
        bottomRightRadius: Theme.get.bottomRightRadius
        bottomLeftRadius: Theme.get.bottomLeftRadius
        topRightRadius: Theme.topRightRadius
        topLeftRadius: Theme.topLeftRadius

        color: Theme.get.backgroundDefault
        implicitWidth: row_workspaces.implicitWidth + 10
        Row {
            id: row_workspaces
            spacing: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            Repeater {
                model: Utils.HyprlandUtils.focusedmonitor_workspaces

                BarBlock {
                  required property int index
                  property bool focused: Hyprland.focusedMonitor?.activeWorkspace?.id === Utils.HyprlandUtils.focusedmonitor_workspaces[index].id

                  width: workspaceText.width
                  height: workspaceText.height + 2.5
                  id: text
                  content: BarText {
                    id: workspaceText
                    symbolText: (Utils.HyprlandUtils.focusedmonitor_workspaces[index].id).toString()
                    color: focused ? "#70e6e0" : "white" 
                  }
                  color: "transparent"
                }
           }
        }
    }
}
