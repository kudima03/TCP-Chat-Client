#ifndef TCPCHATCLIENT_H
#define TCPCHATCLIENT_H

#include <QObject>
#include<QTcpSocket>

class TcpChatClient : public QObject
{
    Q_OBJECT
protected:

    QTcpSocket* socket;

public:
    explicit TcpChatClient(QObject *parent = nullptr);

public slots:

    void onConnectToServer(const QString& ip, const QString& port);
    void onSendMessage(const QString& message);

protected slots:

    void onConnected();
    void onErrorOccured(QAbstractSocket::SocketError error);
    void onReadyRead();

signals:

    void newMessage(const QByteArray& message);
};

#endif // TCPCHATCLIENT_H
