
package project.simulations;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;


//
// TODO documentation
//
network AppNet
{
    @display("bgb=797,443");
    submodules:
        router: Router {
            @display("p=362,166");
        }
        Client1: StandardHost {
            @display("p=118,103");
        }
        Server: StandardHost {
            @display("p=642,113");
        }
        Client2: StandardHost {
            @display("p=118,264");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=524,32");
        }
        client[1]: StandardHost {
            @display("p=100,100");
        }
    connections:
        router.ethg++ <--> Eth100M <--> Server.ethg++;
        router.ethg++ <--> Eth100M <--> Client1.ethg++;
        router.ethg++ <--> Eth100M <--> Client2.ethg++;
        for i=0..9{
            
            router.ethg++ <--> Eth100M <--> client[i].ethg++;
        }
}

