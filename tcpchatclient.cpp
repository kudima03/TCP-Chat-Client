#include "tcpchatclient.h"

TcpChatClient::TcpChatClient(QObject *parent)
    : QObject{parent}
{
    socket = new QTcpSocket();
    connect(socket, &QTcpSocket::connected, this, &TcpChatClient::onConnected);
    connect(socket, &QTcpSocket::errorOccurred, this, &TcpChatClient::onErrorOccured);
    connect(socket, &QTcpSocket::readyRead, this, &TcpChatClient::onReadyRead);
}

void TcpChatClient::onConnectToServer(const QString &ip, const QString &port)
{
    socket->connectToHost(ip, port.toUInt());
}

void TcpChatClient::onSendMessage(const QString &message)
{
    socket->write(message.toUtf8());
    socket->flush();
}

void TcpChatClient::onConnected()
{
    qInfo()<<"Connected to host";
}

void TcpChatClient::onErrorOccured(QAbstractSocket::SocketError error)
{
    qWarning()<<"Error: "<<error;
}

void TcpChatClient::onReadyRead()
{
    const auto message = socket->readAll();
    emit newMessage(message);
}
