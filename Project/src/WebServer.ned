package project;

import inet.applications.tcpapp.TCPSrvHostApp;

simple WebServer extends TCPSrvHostApp{
    
    parameters:
        localAddress = "";
		localPort = 80;
		serverThreadClass="TCPGenericSrvThread";
}
