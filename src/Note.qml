import QtQuick 2.15
import QtQuick.Controls 2.15
import org.julialang 1.0

Row {
    Button {
        font.pointSize: button_text_size
        implicitWidth: button_side
        implicitHeight: button_side
        text: "+"
        onClicked: {
            notes_model.insert(index, [])
            yaml.text = Julia.to_yaml()
        }
    }
    Column {
        spacing: default_spacing
        Button {
            font.pointSize: button_text_size
            implicitWidth: button_side
            implicitHeight: button_side
            anchors.horizontalCenter: parent.horizontalCenter
            text: remove_text
            onClicked: {
                notes_model.remove(index)
                yaml.text = Julia.to_yaml()
            }
        }
        Interval {}
        Row {
            Button {
                font.pointSize: button_text_size
                implicitWidth: button_side
                implicitHeight: button_side
                text: "▶️"
                onPressed: {
                    Julia.press(chord_index, index)
                }
                onCanceled: {
                    Julia.release()
                }
                onReleased: {
                    Julia.release()
                }
            }
            Beats { }
        }
    }
}