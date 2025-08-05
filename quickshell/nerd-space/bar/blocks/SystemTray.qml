import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "root:/bar"
import "root:/"

Rectangle {
    color: "#AA000000"
    implicitWidth: system_tray_item.implicitWidth + 7.5
    Layout.preferredHeight: Theme.get.preferredHeight

    bottomRightRadius: Theme.get.bottomRightRadius
    bottomLeftRadius: Theme.get.bottomLeftRadius
    topRightRadius: Theme.topRightRadius
    topLeftRadius: Theme.topLeftRadius


    RowLayout {
        id: system_tray_item
        spacing: 5
        anchors.fill: parent
        anchors.margins: 2.5
        Repeater {
            model: ScriptModel {
                values: {[...SystemTray.items.values]
                    .filter((item) => {
                        return (item.id != "spotify-client"
                             && item.id != "chrome_status_icon_1")
                    })
                }
            }

            MouseArea {
                id: delegate
                required property SystemTrayItem modelData
                property alias item: delegate.modelData

                Layout.fillHeight: true
                implicitWidth: icon.implicitWidth + 5

                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                hoverEnabled: true

                onClicked: event => {
                    if (event.button == Qt.LeftButton) {
                        item.activate();
                    } else if (event.button == Qt.MiddleButton) {
                        item.secondaryActivate();
                    } else if (event.button == Qt.RightButton) {
                        menuAnchor.open();
                    }
                }

                onWheel: event => {
                    event.accepted = true;
                    const points = event.angleDelta.y / 120
                    item.scroll(points, false);
                }

                IconImage {
                    id: icon
                    anchors.centerIn: parent
                    source: item.icon
                    implicitSize: 12
                }

                QsMenuAnchor {
                    id: menuAnchor
                    menu: item.menu

                    anchor.window: delegate.QsWindow.window
                    anchor.adjustment: PopupAdjustment.Flip

                    anchor.onAnchoring: {
                        const window = delegate.QsWindow.window;
                        const widgetRect = window.contentItem.mapFromItem(delegate, 0, delegate.height, delegate.width, delegate.height);

                        menuAnchor.anchor.rect = widgetRect;
                    }
                }

                Tooltip {
                    relativeItem: delegate.containsMouse ? delegate : null

                    Label {
                        text: delegate.item.tooltipTitle || delegate.item.id
                    }
                }
            }
        }
    }
}

