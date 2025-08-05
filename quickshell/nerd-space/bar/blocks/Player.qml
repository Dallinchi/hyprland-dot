import QtQuick
import "../utils"
import "../"

BarBlock {
  id: text

  property int chopLength
  property string title: PlayerTitle.title
  
  content: BarText {
    symbolText: {
      var str = title
      return str.length > chopLength ? str.slice(0, chopLength) + '...' : str;
    }
  }
}

