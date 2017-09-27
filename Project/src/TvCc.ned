package project;

import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;

module TvCc
{
    parameters:
        int numIpCam = default(4);		//numero telecamere ip
        @display("i=device/device");
    gates:
        inout ethg;
	   
    submodules:

        cctvSwitch: EtherSwitch {

            @display("p=232,192");
        }

        ipCam[numIpCam]: StandardHost {

            parameters:

                @display("p=232,64,ri,200,80;i=MieIcone/camera;is=n");
        }

        dvr: StandardHost {

            parameters:

                @display("p=83,193;i=MieIcone/tv;is=n");
        }

    connections:

        cctvSwitch.ethg++ <--> ethg;
        cctvSwitch.ethg++ <--> Eth100M <--> dvr.ethg++;
        for i=0..numIpCam-1 {
            ipCam[i].ethg++ <--> Eth100M <--> cctvSwitch.ethg++;
        }
}
