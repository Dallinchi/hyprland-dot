import QtQuick
import "../"
import "../utils"

BarBlock {
  id: text
  content: BarText {
    symbolText: ` ${Datetime.time}`
  }
}

