# Starting and stopping your environment

This section provides additional notes to supplement the [product documentation.](https://www.ibm.com/docs/en/baw/24.x?topic=workflow-starting-your-environment-verifying-installation)

To start your environment:

* Log into the BPM server as **wasadmin**.
* [Start the deployment manager](#starting-and-stopping-the-deployment-manager)
* [Start the nodes](#starting-and-stopping-the-node-agent)
* [Start the deployment environment](#starting-and-stopping-deployment-environments)
* [Verify the environment](#verify-the-environment)
* [Default BAW URLs](#baw-urls)

Reverse the order to stop the deployment environment.

## Starting and stopping the deployment manager

Perform these steps to start the deployment manager

```sh
cd /opt/ibm/BAW/v24.0/profiles/DmgrProfile/bin/
./startManager.sh
```

The response will be similar to this:

```text
CWUPO0001I: Running configuration action detectNewProducts.ant
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/DmgrProfile/logs/dmgr/startServer.log
ADMU0128I: Starting tool with the DmgrProfile profile
ADMU3100I: Reading configuration for server: dmgr
ADMU3200I: Server launched. Waiting for initialization status.
ADMU3000I: Server dmgr open for e-business; process id is 3317
```

Perform these steps to stop the deployment manager

```sh
cd /opt/ibm/BAW/v24.0/profiles/DmgrProfile/bin/
./stopManager.sh -username <DmgrAdmin> -password <DmgrAdminpw>
```

The response will be similar to this:

```text
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/DmgrProfile/logs/dmgr/stopServer.log
ADMU0128I: Starting tool with the DmgrProfile profile
ADMU3100I: Reading configuration for server: dmgr
ADMU3201I: Server stop request issued. Waiting for stop status.
ADMU4000I: Server dmgr stop completed.
```

## Starting and stopping the node agent

Perform these steps to start the node agent

```sh
cd /opt/ibm/BAW/v24.0/profiles/Node1Profile/bin/
./startNode.sh
```

The response will be similar to this:

```text
CWUPO0001I: Running configuration action detectNewProducts.ant
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/Node1Profile/logs/nodeagent/startServer.log
ADMU0128I: Starting tool with the Node1Profile profile
ADMU3100I: Reading configuration for server: nodeagent
ADMU3200I: Server launched. Waiting for initialization status.
ADMU3000I: Server nodeagent open for e-business; process id is 3800
```

Perform these steps to stop the node agent

```sh
cd /opt/ibm/BAW/v24.0/profiles/Node1Profile/bin/
./stopNode.sh  -username <DmgrAdmin> -password <DmgrAdminpw>
```

The response will be similar to this:

```text
ADMU0116I: Tool information is being logged in file
           /opt/ibm/BAW/v24.0/profiles/Node1Profile/logs/nodeagent/stopServer.log
ADMU0128I: Starting tool with the Node1Profile profile
ADMU3100I: Reading configuration for server: nodeagent
ADMU3201I: Server stop request issued. Waiting for stop status.
ADMU4000I: Server nodeagent stop completed.
```

## Starting and stopping deployment environments

Perform these steps to start the deployment environment

```sh
cd /opt/ibm/BAW/v24.0/bin
./BPMConfig.sh -start -profile DmgrProfile -de De1
```

The response will be similar to this:

```text
Logging to file /opt/ibm/BAW/v24.0/logs/config/BPMConfig_start_DmgrProfile_De1_20241112-155411.log.
Starting cluster SingleCluster.
When the BPMConfig command is used to start a deployment environment, it invokes the processes that are used to start the associated clusters. If the command is successful in invoking the processes, it returns a message to report that the command completed successfully. However, to determine whether the cluster members were all started successfully, you need to check the log files of the cluster members. The log files are located in <profile_root>/logs.
The 'BPMConfig.sh -start -profile DmgrProfile -de De1' command completed successfully.
```

Perform these steps to stop the deployment environment

```sh
cd /opt/ibm/BAW/v24.0/bin
./BPMConfig.sh -stop -profile DmgrProfile -de De1  -username <DmgrAdmin> -password <DmgrAdminpw>
```

The response will be similar to:

```text
Logging to file /opt/ibm/BAW/v24.0/logs/config/BPMConfig_stop_DmgrProfile_De1_20241112-162649.log.
Stopping cluster SingleCluster.
The 'BPMConfig.sh -stop -profile DmgrProfile -de De1 -username <DmgrAdmin> -password ********' command completed successfully.
```

## Verify the environment

1. Log into the WebSphere Administration console at **<https://host:9043/ibm/console>** using **DmgrAdmin* credentials.

2. Verify ypu can see **IBM Business Automation Workflow** on the Welcome page

3. Check that the enterprise applications are started by clicking **Applications > Application Types > WebSphere enterprise applications**

4. Check that the messaging engine is started by clicking **Service integration > Buses**. Then click the name of the bus, and under **Topology**, click **Messaging** engines.

5. Verify that the Failed Event Manager is enabled. Click **Servers > Deployment Environments**. Click the name of the deployment environment, and under **Additional Properties**, click **Failed Event Manager**

## BAW URLs

These are the default URLs for BAW

* WebSphere Admin Console: <https://hostname:9080/ibm/console/>
* Process Center: <http://hostname:9080/ProcessCenter/>
* Process Admin: <http://hostname:9080/ProcessAdmin/>
* Performance Admin: <http://hostname:9080/PerformanceAdmin/>
