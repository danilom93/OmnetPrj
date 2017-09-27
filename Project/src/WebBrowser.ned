package project;

import inet.applications.tcpapp.TCPBasicClientApp;

simple WebBrowser extends TCPBasicClientApp{
    
    parameters:
		localAddress = "";
		localPort = -1;
		connectPort = 80;
		startTime = exponential(5s);
		numRequestsPerSession = 1;
		requestLength = truncnormal(350B,20B);
		replyLength = exponential(2000B);
		thinkTime = truncnormal(2s,3s);
		idleInterval = truncnormal(3600s,1200s);
		reconnectInterval = 30s;
}

