import QtQuick
import "../"
import "../utils"

BarBlock {
  id: text
  content: BarText {
    symbolText: ` ${Datetime.date}` 
    // symbolSize: pointSize * 1.1
  }
}

