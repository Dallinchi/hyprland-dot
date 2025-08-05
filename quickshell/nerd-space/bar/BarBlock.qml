import QtQuick
import QtQuick.Layouts
import Quickshell

import "root:/"

Rectangle {
    id: root
    Layout.preferredWidth: contentContainer.implicitWidth + content.symbolsWidth + 20
    // Layout.preferredWidth: contentContainer.implicitWidth + content.symbolsWidth + (content.symbolsWidth > 0 ? 0 : 20)
    Layout.preferredHeight: Theme.get.preferredHeight

    property Item content
    property Item mouseArea: mouseArea

    property string text
    property bool dim: false
    property bool underline
    property var onClicked: function() {}
    property string hoveredBgColor: Theme.get.backgroundActive

    bottomRightRadius: Theme.get.bottomRightRadius
    bottomLeftRadius: Theme.get.bottomLeftRadius
    topRightRadius: Theme.topRightRadius
    topLeftRadius: Theme.topLeftRadius

    visible: content.text.length >= 1

    // Background color
    color: {
        if (mouseArea.containsMouse)
            return hoveredBgColor;
        return Theme.get.backgroundDefault;
    }

    states: [
        State {
            when: mouseArea.containsMouse
            PropertyChanges {
                target: root
            }
        }
    ]

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }

    // Контейнер для отступов
    Item {
      anchors.fill: parent

      Item {
            // Contents of the bar block
            id: contentContainer
            implicitWidth: content ? content.implicitWidth : 0
            implicitHeight: content ? content.implicitHeight : 0
            // anchors.centerIn: parent
            // Знаете что? А мне похуй, идите нахуй!
            // anchors.right: parent.right
            // anchors.right: content.symbolsWidth > 0 ? parent.right : undefined
            anchors.horizontalCenter: content.symbolsWidth === 0 ? parent.horizontalCenter : undefined
            x: content.symbolsWidth > 0 ? +29 : 0 
            children: content
        }

      MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onClicked: root.onClicked()
        }

        // While line underneath workspace
      Rectangle {
            id: wsLine
            width: parent.width
            height: 2

            color: {
                if (parent.underline)
                    return "white";
                return "transparent";
            }
            anchors.bottom: parent.bottom
        }
    }
}

