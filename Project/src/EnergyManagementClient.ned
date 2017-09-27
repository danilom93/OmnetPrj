
package project;

import inet.applications.contract.ITCPApp;

simple EnergyManagementClient like ITCPApp{

	parameters:
	    string localAddress = default(""); // local address or empty ("")
        int localPort = default(0); // local port number
        string connectAddress;  // server address (may be symbolic)
        int connectPort = default(9000); // port number to connect to
        string dataTransferMode;
        int startTime = default(0);
        int numId = default(0);
        int retryTime = default(1);
        int reconnectionTime = default(5);
        bool eventLog = default(false);
        @signal[sentPk](type=cPacket);
        @signal[rcvdPk](type=cPacket);
        @signal[connect](type=long);  // 1 for open, -1 for close
	gates:
        input tcpIn @labels(TCPCommand/up);
        output tcpOut @labels(TCPCommand/down);   
}