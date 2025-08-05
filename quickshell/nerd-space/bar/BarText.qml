import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

Text {
  id: root

  property string mainFont: "monospace"
  property string symbolFont: "Symbols Nerd Font Mono"
  property int pointSize: 10
  property int symbolSize: pointSize * 1.3
  property string symbolText
  property bool dim
  property int symbolsWidth: symbols.implicitWidth * 0.9

  // width: root.implicitWidth + symbols.implicitWidth
  text: wrapText(symbolText)
  color: dim ? "#CCCCCC" : "#ffffff"
  textFormat: Text.RichText
  font {
    family: mainFont
    pointSize: pointSize
  }
  
  Text {
    id: symbols
    text: wrapSymbols(symbolText)
    color: parent.color
    font {
      family: symbolFont
      pointSize: symbolSize
    }
    anchors.right: parent.left 
    anchors.verticalCenter: parent.verticalCenter 
    anchors.margins: 5
  }

  function wrapSymbols(text) {
    if (!text)
      return ""

    const isSymbol = (codePoint) =>
        (codePoint >= 0xE000   && codePoint <= 0xF8FF) // Private Use Area
     || (codePoint >= 0xF0000  && codePoint <= 0xFFFFF) // Supplementary Private Use Area-A
     || (codePoint >= 0x100000 && codePoint <= 0x10FFFF); // Supplementary Private Use Area-B

    return text.replace(/./gu, (c) => isSymbol(c.codePointAt(0))
      ? `<span style='font-family: ${symbolFont}; font-size: ${symbolSize}px'>${c}</span>`
      : '');
  }
  
  function wrapText(text) {
    if (!text)
      return ""

    const isSymbol = (codePoint) =>
        (codePoint >= 0xE000   && codePoint <= 0xF8FF) // Private Use Area
     || (codePoint >= 0xF0000  && codePoint <= 0xFFFFF) // Supplementary Private Use Area-A
     || (codePoint >= 0x100000 && codePoint <= 0x10FFFF); // Supplementary Private Use Area-B

    return text.replace(/./gu, (c) => isSymbol(c.codePointAt(0))
      ? ``
      : c);
  }
}

