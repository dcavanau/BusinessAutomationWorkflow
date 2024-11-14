# Create Profiles

This section provides additional notes to supplement the [product documentation](https://www.ibm.com/docs/en/baw/24.x?topic=ubc-creating-profiles-network-deployment-environments-database-tables-using-bpmconfig).

To generate the database scripts that can be used by the **BPMConfig** command to create and configure your databases, you can run **BPMConfig** with the **-create -sqlfiles** parameters, and additionally include the **-outputDir** parameter to specify a location for the generated scripts. When you run the **BPMConfig** command with these parameters, it generates the database scripts without configuring your environment.

The configuration properties file used for this example is [Advanced Process Center Signle Cluster DB2](./Advanced-PC-SingleCluster-DB2.properties). The file should be placed in the `/opt/install` directory.

Execute the following commands on the BPM Virtual Machine as _wasadmin_:

   ```sh
   cd /opt/ibm/BAW/v24.0/bin/
   ./BPMConfig.sh -create -de /opt/install/Advanced-PC-SingleCluster-DB2.properties
   ```

The response will be similar to this:

```text
Logging to file /opt/ibm/BAW/v24.0/logs/config/BPMConfig_create_DmgrProfile_De1_20241111-110035.log.
Validating the profile registry.
[]
Configuring the deployment manager.
Creating the deployment manager profile.
INSTCONFSUCCESS: Success: Profile DmgrProfile now exists. Please consult /opt/ibm/BAW/v24.0/profiles/DmgrProfile/logs/AboutThisProfile.txt for more information about this profile.
Starting deployment manager profile DmgrProfile.
CWUPO0001I: Running configuration action detectNewProducts.ant
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/DmgrProfile/logs/dmgr/startServer.log
ADMU0128I: Starting tool with the DmgrProfile profile
ADMU3100I: Reading configuration for server: dmgr
ADMU3200I: Server launched. Waiting for initialization status.
ADMU3000I: Server dmgr open for e-business; process id is 25442
Configuring managed node profiles.
Creating the managed node Node1 profile.
INSTCONFSUCCESS: Success: Profile Node1Profile now exists. Please consult /opt/ibm/BAW/v24.0/profiles/Node1Profile/logs/AboutThisProfile.txt for more information about this profile.
Adding the node Node1 to the cell PCCell1.
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/Node1Profile/logs/addNode.log
ADMU0128I: Starting tool with the Node1Profile profile
CWPKI0308I: Adding signer alias "CN=bpmauth.local, OU=Root Certi" to local
           keystore "ClientDefaultTrustStore" with the following SHA digest:
           3B:EB:2E:8D:90:25:A7:68:98:10:AC:08:F6:8D:C9:6A:28:20:9C:DB
CWPKI0309I: All signers from remote keystore already exist in local keystore.
ADMU0001I: Begin federation of node Node1 with Deployment Manager at
           bpmauth.local:8879.
ADMU0009I: Successfully connected to Deployment Manager Server:
           bpmauth.local:8879
ADMU0507I: No servers found in configuration under:
           /opt/ibm/BAW/v24.0/profiles/Node1Profile/config/cells/PCCell1Node1/nodes/Node1/servers
ADMU2010I: Stopping all server processes for node Node1
ADMU0024I: Deleting the old backup directory.
ADMU0015I: Backing up the original cell repository.
ADMU0012I: Creating Node Agent configuration for node: Node1
ADMU0014I: Adding node Node1 configuration to cell: PCCell1
ADMU0016I: Synchronizing configuration between node and cell.


ADMU0300I: The node Node1 was successfully added to the PCCell1 cell.


ADMU0306I: Note:
ADMU0302I: Any cell-level documents from the standalone PCCell1 configuration
           have not been migrated to the new cell.
ADMU0307I: You might want to:
ADMU0303I: Update the configuration on the PCCell1 Deployment Manager with
           values from the old cell-level documents.


ADMU0306I: Note:
ADMU0304I: Because -includeapps was not specified, applications installed on
           the standalone node were not installed on the new cell.
ADMU0307I: You might want to:
ADMU0305I: Install applications onto the PCCell1 cell using wsadmin $AdminApp
           or the Administrative Console.


ADMU0003I: Node Node1 has been successfully federated.
Generating database configuration files to /opt/ibm/BAW/v24.0/profiles/DmgrProfile/dbscripts/PCCell1.
Generating database configuration files to /opt/ibm/BAW/v24.0/profiles/DmgrProfile/dbscripts/PCCell1.De1.
Provisioning cell.
Generating database configuration files to /opt/ibm/BAW/v24.0/profiles/DmgrProfile/dbscripts/PCCell1.
Configuring the cell.
Configuring the deployment manager.
Provisioning deployment environment.
Generating database configuration files to /opt/ibm/BAW/v24.0/profiles/DmgrProfile/dbscripts/PCCell1.De1.
Performing security configuration.
Creating clusters.
Configuring data sources.
Configuring the databases.
Configuring cluster SingleCluster for capability Messaging.
Configuring cluster SingleCluster for capability Application.
Configuring cluster SingleCluster for capability Support.
Provisioning managed node Node1.
Creating cluster members.
The HTTP and HTTPS ports for server SingleClusterMember1 on node Node1 are added to the virtual hosts list.
Configuring the REST services end points.
Saving configuration changes...
Synchronizing node Node1.
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/Node1Profile/logs/syncNode.log
ADMU0128I: Starting tool with the Node1Profile profile
ADMU0401I: Begin syncNode operation for node Node1 with Deployment Manager
           bpmauth.local: 8879
ADMU0016I: Synchronizing configuration between node and cell.
ADMU0402I: The configuration for node Node1 has been synchronized with
           Deployment Manager bpmauth.local: 8879
Stopping deployment manager profile DmgrProfile.
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/DmgrProfile/logs/dmgr/stopServer.log
ADMU0128I: Starting tool with the DmgrProfile profile
ADMU3100I: Reading configuration for server: dmgr
ADMU3201I: Server stop request issued. Waiting for stop status.
ADMU4000I: Server dmgr stop completed.

The 'BPMConfig.sh -create -de /opt/install/CIGNA-Advanced-PC-SingleCluster-DB2.properties' command completed successfully.
```

[BACK](./install-traditional.md)
