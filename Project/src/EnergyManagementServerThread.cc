/*
 * EnergyManagementServerThread.cc
 *
 *  Created on: 08/lug/2016
 *      Author: danilo
 */

#include "EnergyManagementServerThread.h"
#include "omnetpp.h"

#include "inet/applications/tcpapp/GenericAppMsg_m.h"

using namespace inet;

Register_Class(EnergyManagementServerThread);

void EnergyManagementServerThread::dataArrived(cMessage *msg, bool){

    char tmp[50] = {0};
    cMersenneTwister rand;

    GenericAppMsg *appmsg = dynamic_cast<GenericAppMsg *>(msg);

    EV_INFO << "\n---Ricevuto messaggio..." << msg->getName() << "---\n";

    if (!appmsg)
        throw cRuntimeError("Message (%s)%s is not a GenericAppMsg -- "
                            "probably wrong client app, or wrong setting of TCP's "
                            "dataTransferMode parameters "
                            "(try \"object\")", msg->getClassName(), msg->getName());

    bool close = appmsg->getServerClose();


    strcpy(tmp, "Nuova richiesta: ");
    strcat(tmp, appmsg->getName());
    this->getHostModule()->getParentModule()->bubble(tmp);


    if(strstr(appmsg->getName(), "TryOn")){

        if(rand.intRand() % 2 == 0){

            EV_INFO << "\n---Risposta--->>>>..." << "OK" << "---\n";
            appmsg->setName("OK");
            appmsg->setByteLength(strlen("OK"));
            delete appmsg->removeControlInfo();
            getSocket()->send(appmsg);

        }else{

            EV_INFO << "\n---Risposta--->>>>..." << "FAIL" << "---\n";
            appmsg->setName("FAIL");
            appmsg->setByteLength(strlen("FAIL"));
            delete appmsg->removeControlInfo();
            getSocket()->send(appmsg);
        }
    }else{

        delete appmsg;
    }

    if (close){

        getSocket()->close();
        EV_INFO << "\n\n\n\n\n\nCHIUSURA SERVER\n\n\n\n\n\n";
    }
}

