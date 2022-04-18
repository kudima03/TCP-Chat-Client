import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.12

Window {
    width: 640
    height: 480
    minimumHeight: 280
    minimumWidth: 440
    visible: true
    title: qsTr("Chat client")

    Connections
    {
        target: client
        function onNewMessage(message)
        {
            listModelMessages.append({message: message + ""});
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        RowLayout
        {
            TextField
            {
                id: textFieldIp
                placeholderText: qsTr("IP сервера: ")
                Layout.fillWidth: true
                validator: RegularExpressionValidator
                {
                    regularExpression:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                }
                onAccepted: buttonConnect.clicked()

            }
            Button
            {
                id: buttonConnect
                text: qsTr("Подключиться")
                onClicked: client.onConnectToServer(textFieldIp.text, 40000)
            }
        }
        ListView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: ListModel
            {
                id: listModelMessages
                ListElement
                {
                    message: "Добро пожаловать в чат!";
                }
            }
            delegate: ItemDelegate
            {
                text: message
            }
            ScrollBar.vertical: ScrollBar{}
        }
        RowLayout
        {
            TextField
            {
                id: textFieldMessage
                placeholderText: qsTr("Ваше сообщение: ")
                Layout.fillWidth: true
                onAccepted: buttonSend

            }
            Button
            {
                id: buttonSend
                text: qsTr("Отправить")
                onClicked:
                {
                    client.onSendMessage(textFieldMessage.text)
                    textFieldMessage.clear()
                }
            }
        }
    }
}
