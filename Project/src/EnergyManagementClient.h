#ifndef ENERGY_MANAGEMENT_CLIENT_H_
#define ENERGY_MANAGEMENT_CLIENT_H_

#include <iostream>
#include <fstream>
#include  "inet/applications/tcpapp/TCPAppBase.h"

using namespace inet;

class EnergyManagementClient: public TCPAppBase {

    public:

                            EnergyManagementClient();
        virtual             ~EnergyManagementClient();

    protected:

        virtual     void    initialize(int stage) override;
        virtual     void    handleTimer(cMessage *msg) override;

                    void    sendMsg();

        virtual     void    socketEstablished(int connId, void *yourPtr) override;

        virtual     void    socketDataArrived(int connId, void *yourPtr, cPacket *msg, bool urgent) override;

        virtual     void    socketClosed(int connId, void *yourPtr) override;

        virtual     void    socketFailure(int connId, void *yourPtr, int code) override;

                    void    evLog(std::string str);
    private:

        cMessage        * m_msg;
        int             m_id;
        std::ofstream   m_file;
        bool            m_log;
};


#endif
