import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks
import "root:/"

Scope {
  IpcHandler {
    target: "bar"

    function toggleVis(): void {
      // Toggle visibility of all bar instances
      for (let i = 0; i < Quickshell.screens.length; i++) {
        barInstances[i].visible = !barInstances[i].visible;
      }
    }
  }

  property var barInstances: []

  Variants {
    model: Quickshell.screens
  
    PanelWindow {
      id: bar
      property var modelData
      screen: modelData
      color: "transparent"
      implicitHeight: 21
      visible: true
      
      Component.onCompleted: {
        barInstances.push(bar);
      }

      Rectangle {
        id: highlight
        anchors.fill: parent
        color: Theme.get.background
      }

      anchors {
        top: Theme.get.onTop
        bottom: !Theme.get.onTop
        left: true
        right: true
      }
    
      RowLayout {
        id: allBlocks
        spacing: 0
        anchors.fill: parent
        anchors.topMargin: -3

  
        // Left side
        RowLayout {
          id: leftBlocks
          spacing: 12
          Blocks.Time {
            anchors.left: parent.left
            anchors.leftMargin: 10
          }
          Blocks.Date {}
          Blocks.Workspaces {}
        }
      
        // Center side
        Item {
            id: centerBlocks
            anchors.fill: parent

            RowLayout {
              anchors.centerIn: parent 
              spacing: 10
                Blocks.ActiveWorkspace {
                  chopLength: {
                    var space = Math.floor(bar.width - (rightBlocks.implicitWidth + leftBlocks.implicitWidth))
                    return space * 0.07; // Множитель длины текста
                  }
                }
            }
        }

        // Right side
        RowLayout {
          id: rightBlocks
          spacing: 10
          Layout.alignment: Qt.AlignRight
          Layout.fillWidth: true
          
          Blocks.Player {
            chopLength: {
              var space = Math.floor(bar.width - (centerBlocks.implicitWidth + leftBlocks.implicitWidth))
                return space * 0.02; // Множитель длины текста
              }

          }
          Blocks.SystemTray {}
          // Blocks.Memory {}
          Blocks.Sound {}
          Blocks.Language {}
          Blocks.Battery {}
        }
      }
    }
  }
}

