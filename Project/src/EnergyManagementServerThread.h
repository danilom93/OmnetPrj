#ifndef ENERGYMANAGEMENTSERVERTHREAD_H_
#define ENERGYMANAGEMENTSERVERTHREAD_H_

#include "inet/applications/tcpapp/TCPGenericSrvThread.h"

using namespace inet;

class INET_API EnergyManagementServerThread : public TCPGenericSrvThread{

    public:
                        EnergyManagementServerThread() : TCPGenericSrvThread() {}
        virtual void    dataArrived(cMessage *msg, bool urgent);

};

#endif /* ENERGYMANAGEMENTSERVERTHREAD_H_ */
