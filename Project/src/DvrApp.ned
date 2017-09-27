package project;

import inet.applications.udpapp.UDPVideoStreamCli;

simple DvrApp extends UDPVideoStreamCli{
    
    parameters:
        
     	string serverAddressUp;
        string serverAddressDown;
        
        serverAddress = serverAddressUp + serverAddressDown;
        serverPort = 9000; 
}