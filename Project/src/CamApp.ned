package project;

import inet.applications.udpapp.UDPVideoStreamSvr;

simple CamApp extends UDPVideoStreamSvr{
    
    localPort = 9000;
    sendInterval = 10ms;
    packetLen = 1000B;
    videoSize = 10GiB; 
}