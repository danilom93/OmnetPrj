#include "EnergyManagementClient.h"

#include "inet/common/ModuleAccess.h"
#include "inet/common/lifecycle/NodeStatus.h"
#include "inet/common/lifecycle/NodeOperations.h"
#include "inet/applications/tcpapp/GenericAppMsg_m.h"

using namespace inet;

Define_Module(EnergyManagementClient);

#define CONNECT_STATE   0
#define SENDMSG_STATE   1

EnergyManagementClient::EnergyManagementClient() : TCPAppBase(), m_msg(nullptr), m_log(false){

}

EnergyManagementClient::~EnergyManagementClient(){

    cancelAndDelete(m_msg);
}

void EnergyManagementClient::initialize(int stage){

    TCPAppBase::initialize(stage);

    if (stage == INITSTAGE_APPLICATION_LAYER) {

        bool isOperational;
            NodeStatus *nodeStatus = dynamic_cast<NodeStatus *>(findContainingNode(this)->getSubmodule("status"));
            isOperational = (!nodeStatus) || nodeStatus->getState() == NodeStatus::UP;
            if (!isOperational)
                throw cRuntimeError("This module doesn't support starting in node DOWN state");

            EV_TRACE << "\n---Provo a connettermi---\n";
            m_id = par("numId");
            m_log = par("eventLog");
            m_msg = new cMessage("timer");
            m_msg->setKind(CONNECT_STATE);
            scheduleAt(simTime() + par("startTime"), m_msg);
        }
}

void EnergyManagementClient::handleTimer(cMessage *msg){

    switch(msg->getKind()){

    case SENDMSG_STATE:

        EV_TRACE << "\n---Invio il messaggio...---\n";
        sendMsg();
        break;

    case CONNECT_STATE:

        EV_TRACE << "\n---Connessione in corso...---\n";

        if(m_log){

            m_file.open(this->getFullPath() + ".txt", std::ios::out | std::ios::app);
        }
        evLog("\n---Provo a connettermi...---\n");
        connect();
        break;
    }
}

void EnergyManagementClient::socketEstablished(int connId, void *ptr){

    TCPAppBase::socketEstablished(connId, ptr);
    EV_TRACE << "\n---Connesso...---\n";

    evLog("\n---Connesso...---\n");

    m_msg->setKind(SENDMSG_STATE);
    scheduleAt(simTime(), m_msg);
}

void EnergyManagementClient::sendMsg(){

    std::string buffer;

    EV_TRACE << "\n---Invio...---\n";
    buffer += "TryOn, Id=";
    buffer += std::to_string(m_id);

    GenericAppMsg *msg = new GenericAppMsg(buffer.c_str());
    msg->setByteLength(strlen(buffer.c_str()));
    msg->setServerClose(false);

    evLog(buffer);

    sendPacket(msg);
}

void EnergyManagementClient::socketDataArrived(int connId, void *ptr, cPacket *msg, bool urgent){

    EV_INFO  << "\n---Ricevuto messaggio\n" << msg->getName() << "---\n";

    evLog("\n---Ricevuto messaggio --> " + std::string(msg->getName()) + "---\n");

    cPacket myMsg = *msg;
    TCPAppBase::socketDataArrived(connId, ptr, msg, urgent);

    if(strcmp(myMsg.getName(), "OK") == 0){

        EV_INFO << "\n---Rilascio il server ON---\n";

        this->getParentModule()->bubble("ACCENSIONE ACCETTATA");

        evLog("\n---Accensione accettata---\n");

        GenericAppMsg *msg = new GenericAppMsg("OK");
        msg->setByteLength(strlen("OK"));
        msg->setServerClose(true);
        sendPacket(msg);

    }else{

        EV_INFO << "\n---Riprovo dopo... L=OFF---\n";
        this->getParentModule()->bubble("ACCENSIONE RIFIUTATA");

        evLog("\n---Accensione rifiutata---\n");

        m_msg->setKind(SENDMSG_STATE);
        scheduleAt(simTime() + par("retryTime"), m_msg);
    }

}

void EnergyManagementClient::socketClosed(int connId, void *ptr){

    TCPAppBase::socketClosed(connId, ptr);
    m_msg->setKind(CONNECT_STATE);
    scheduleAt(simTime() + par("reconnectionTime"), m_msg);

    EV_INFO << "\n---Socket chiusa... evento successivo programmato---\n";

    evLog("\n---Socket chiusa... evento successivo programmato---\n");
    if(m_log){

        m_file.close();
    }
}

void EnergyManagementClient::socketFailure(int connId, void *ptr, int code){

    TCPAppBase::socketFailure(connId, ptr, code);
    EV_INFO << "\n---Socket Errore---\n";
}

void EnergyManagementClient::evLog(std::string str){

    if(m_log){

        m_file << str;
    }
}



