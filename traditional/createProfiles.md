# Create Profiles

To generate the database scripts that can be used by the **BPMConfig** command to create and configure your databases, you can run **BPMConfig** with the **-create -sqlfiles** parameters, and additionally include the **-outputDir** parameter to specify a location for the generated scripts. When you run the **BPMConfig** command with these parameters, it generates the database scripts without configuring your environment.

The configuration properties file used for this example is [CIGNA Advanced Process Center Signle Cluster DB2](./CIGNA-Advanced-PC-SingleCluster-DB2.properties).

1. Execute the following commands on the BPM Virtual Machine as _root_:

   ```sh
   cd /opt/ibm/BPM/v24.0/bin/

   ./BPMConfig.sh -create -de /opt/install/CIGNA-Advanced-PC-SingleCluster-DB2.properties
   ```
