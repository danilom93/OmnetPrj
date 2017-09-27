import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;

package project;

module Flat
{
    parameters:

        int numIpCam = default(4);
        int numHdTv = default(5);
        int numCHost = default(10);
        int numWHost_1 = default(10);
        int numEnClient_1 = default(10);
        int numEnClient_2 = default(10);
        @display("i=device/device;bgb=947.548,658.588");
    gates:
        inout ethg;

    submodules:

        routerFlat: Router {

            parameters:

                @display("p=369,151");

            gates:

                ethg[4];

        }
        switch: EtherSwitch {

            @display("p=550,199");
        }

        cHost[numCHost]: StandardHost {

            @display("p=350,406,ri,200,80");
        }

        tvCc: TvCc {

            @display("p=128,61");
        }

        enServer: StandardHost {

            @display("p=678,311");
        }

        hdTv[numHdTv]: StandardHost {

            @display("p=776,199,ri,80,200");
        }

        accessPoint_1: AccessPoint {

            @display("p=216,253");
        }

        enClient_1[numEnClient_1]: WirelessHost {

            @display("p=295,292");
        }

        enClient_2[numEnClient_2]: StandardHost {

            @display("p=350,54,ri,200,80");
        }

        wHost_1[numWHost_1]: WirelessHost {

            @display("p=128,292");
        }

    connections:

        routerFlat.ethg[0] <--> ethg;

        routerFlat.ethg[1] <--> Eth100M <--> accessPoint_1.ethg++;

        routerFlat.ethg[2] <--> Eth100M <--> switch.ethg++;

        routerFlat.ethg[3] <--> Eth100M <--> tvCc.ethg;

        for i=0..numCHost-1 {
            switch.ethg++ <--> Eth100M <--> cHost[i].ethg++;
        }

        for i=0..numEnClient_2-1 {
            switch.ethg++ <--> Eth100M <--> enClient_2[i].ethg++;
        }

        for i=0..numHdTv-1 {
            switch.ethg++ <--> Eth100M <--> hdTv[i].ethg++;
        }

        switch.ethg++ <--> Eth100M <--> enServer.ethg++;
}
