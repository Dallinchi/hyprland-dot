pragma Singleton

import QtQuick
import Quickshell

Singleton {
  property Item get: cyanSpace
  
  Item {
    id: cyanSpace
    property string accent: "#70e6e0"

    property string textActive: accent
    property string textDefault: "#d2fffd"
    property string textEmpty: "#AAffffff"

    property string backgroundActive: "#cc000000"
    property string backgroundDefault: "#00000000"
    property string backgroundEmpty: "#00000000"
 
    property string blockActive: "#00cccc"
    property string blockDefault: "#AA000000"
    property string blockEmpty: "#12000000"
 
    property string symbolActive: "#00cccc"
    property string symbolDefault: accent
    property string symbolEmpty: "#ccffffff"
 
    property string borderActive: "#222020"
    property string borderDefault: "#transparent"
    property string borderEmpty: "#21ffffff"        

    property string background: backgroundDefault
    property string text: textDefault
    property string block: blockDefault
    property string symbol: symbolDefault
    property string border: borderDefault

    property real bottomRightRadius: 6
    property real bottomLeftRadius: 6
    property real topRightRadius: 0
    property real topLeftRadius: 0
    property real radius: 5

    property bool borderPixelAligned: false
    property real borderWidth: 1
    property real preferredHeight: 21
      
    property real fontSize: 20
    property real fontWeight: 900

    property bool onTop: true

    property real animationDuration: 200 // для смены цветов обычно юзал. Надо бы рефактор бахнуть :\
    property real animationDurationWidth: 100 
    property real animationDurationHeight: 200
  }
}

