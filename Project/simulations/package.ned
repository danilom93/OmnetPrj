package project.simulations;

import inet.linklayer.ieee80211.IIeee80211Mac;
import inet.linklayer.ieee80211.mgmt.Ieee80211MgmtAPSimplified;
import inet.linklayer.ieee80211.mgmt.Ieee80211MgmtSTASimplified;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.EtherSwitch;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth1G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.internetcloud.InternetCloud;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;

import project.Flat;

network Network
{
    parameters:
        int numFlat = default(10);
        int numInternetServer = default(10);
        @display("bgb=1500,550");

    submodules:
        router: Router {
            @display("p=497,52");
        }
        InternetServer[numInternetServer]: StandardHost {
            @display("p=510,216,ri,200,80");
        }
        configurator: IPv4NetworkConfigurator {

            parameters:
                @display("p=58,37");
        }
        etherSwitch: EtherSwitch {
            @display("p=300,51");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=58,100");
        }
        internetCloud: InternetCloud {
            @display("p=616,52");
        }
        router1: Router {
            @display("p=710,125");
        }
        flat[numFlat]: Flat {
            @display("p=200,276,ri,100,80");
        }
    connections:

        etherSwitch.ethg++ <--> Eth1G <--> router.ethg++;

        for i=0..numFlat-1 {
            etherSwitch.ethg++ <--> Eth1G <--> flat[i].ethg;
        }

        router.pppg++ <--> Eth1G <--> internetCloud.pppg++;

        internetCloud.pppg++ <--> Eth1G <--> router1.pppg++;

        for i=0..numInternetServer-1 {
            router1.ethg++ <--> Eth1G <--> InternetServer[i].ethg++;
        }


}

