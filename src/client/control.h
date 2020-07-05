#ifndef CONTROL_H
#define CONTROL_H

#include <QWidget>
#include <client/client.h>
#include <gui/mainwindow.h>

class Control: public QObject
{
    Q_OBJECT
public:
    Control(MainWindow& w);


    // @todo noreturn???
    void work_client(const std::string& login, const std::string& password);

    ~Control() {
        client->close();
    }

signals:
    void send_text_to_gui(const std::string&, const std::string&);

public slots:
    void autorisation(const std::string& login, const std::string& password, int /*room_id*/) {
        std::thread th([this, login, password]() {
            work_client(login, password);
        });
        th.detach();
    }

    void get_text_from_gui(const std::string& login, const std::string& text, int room_id) {
        client->write(std::make_shared<TextRequest>(login, room_id, text));
    }

    void text_from_client(const std::string& from, const std::string& text) {
        send_text_to_gui(from, text);
    }


private:
    std::unique_ptr<Client> client;
    MainWindow &w;
};

#endif // CONTROL_H
