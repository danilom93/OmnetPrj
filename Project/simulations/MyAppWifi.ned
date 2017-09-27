package project.simulations;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
//import inet.visualizer.integrated.IntegratedCanvasVisualizer;


network AppNetWifi
{
    @display("bgb=797,443");
    submodules:

        router: Router {
            @display("p=362,166");
        }

        configurator: IPv4NetworkConfigurator {
            @display("p=459.57373,31.03875");
        }

        accessPoint: AccessPoint {
            @display("p=170.2125,164.205");
        }

        client1: WirelessHost {
            @display("p=107.13375,133.16624");
        }

        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=292.365,31.03875;is=s");
        }

        client2: WirelessHost {
            @display("p=217.27124,122.1525");
        }

        client3: WirelessHost {
            @display("p=217.27124,210.2625");
        }

        client4: WirelessHost {
            @display("p=107.13375,210.2625");
        }

        accessPoint1: AccessPoint {
            @display("p=594.7425,276.345");
        }

        Server: WirelessHost {
            @display("p=668.83496,256.32");
        }
        client5: WirelessHost {
            @display("p=146,76");
        }

        client6: WirelessHost {
            @display("p=82,89");
        }

        client7: WirelessHost {
            @display("p=270,89");
        }

        client8: WirelessHost {
            @display("p=293,198");
        }

        client9: WirelessHost {
            @display("p=283,289");
        }

        client10: WirelessHost {
            @display("p=185,256");
        }

        client11: WirelessHost {
            @display("p=59,155");
        }

        client12: WirelessHost {
            @display("p=107,301");
        }

        client13: WirelessHost {
            @display("p=68,256");
        }

        client14: WirelessHost {
            @display("p=315,122");
        }

        client15: WirelessHost {
            @display("p=202,57");
        }

        client16: WirelessHost {
            @display("p=82,31");
        }

        client17: WirelessHost {
            @display("p=196,322");
        }

    connections:
        accessPoint.ethg++ <--> Eth100M <--> router.ethg++;
        router.ethg++ <--> Eth100M <--> accessPoint1.ethg++;
}

