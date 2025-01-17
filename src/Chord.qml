import QtQuick 2.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.julialang 1.0

Column {
    property int chord_index: index
    width: chords_view.width
    Button {
        font.pointSize: button_text_size
        implicitWidth: button_side
        implicitHeight: button_side
        text: add_text
        onClicked: {
            chords_model.insert(index, [])
            yaml.text = Julia.to_yaml()
        }
    }
    RowLayout {
        width: parent.width
        Button {
            font.pointSize: button_text_size
            text: remove_text
            implicitWidth: button_side
            implicitHeight: button_side
            onClicked: {
                chords_model.remove(index)
                yaml.text = Julia.to_yaml()
            }
        }
        Column {
            id: modulation
            spacing: default_spacing
            TextField {
                text: words
                onEditingFinished: {
                    words = text
                    yaml.text = Julia.to_yaml()
                }
            }
            Row {
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "key = "
                }
                Interval { }
            }
            Row {
                Button {
                    font.pointSize: button_text_size
                    implicitWidth: button_side
                    implicitHeight: button_side
                    text: "▶️"
                    onPressed: {
                        Julia.press(index, -1)
                    }
                    onReleased: {
                        Julia.release()
                    }
                    onCanceled: {
                        Julia.release()
                    }
                }
                Beats { }
            }
        }
        ToolSeparator {
            implicitHeight: parent.height
        }
        ListView {
            id: notes
            Layout.fillWidth: true
            // notes are slightly taller than modulations
            implicitHeight: contentItem.childrenRect.height
            orientation: ListView.Horizontal
            model: notes_model
            delegate: Note { }
            footer: Button {
                implicitWidth: button_side
                implicitHeight: button_side
                font.pointSize: button_text_size
                text: add_text
                onClicked: {
                    notes_model.append([])
                    yaml.text = Julia.to_yaml()
                }
            }
            snapMode: ListView.SnapToItem
            clip: true
        }
    }
}