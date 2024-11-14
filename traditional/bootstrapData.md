# Loading the database with system information

This section provides additional notes to supplement the [product documentation](https://www.ibm.com/docs/en/baw/24.x?topic=path-loading-database-system-information).

When you create a deployment environment, the **bootstrapProcessServerData** command must be completed successfully before you try to start or use Workflow Server or Workflow Center.

The following commands were used for this example.

1. Log into the BPM server as **wasadmin**.

2. Execute the following commands:

   ```sh
   cd /opt/ibm/BAW/v24.0/profiles/DmgrProfile/bin
   ./bootstrapProcessServerData.sh -clusterName SingleCluster
   ```

   The response will be similar to this:

   ```text
   Bootstraping data into cluster SingleCluster and logging into /opt/ibm/BAW/v24.0/profiles/DmgrProfile/logs/bootstrapProcesServerData.SingleCluster_20241111-155023.log

   WASX7357I: By request, this scripting client is not connected to any server process. Certain configuration and application operations will be available in local mode.
   'BootstrapProcessServerData admin command completed successfully.....'
   ```

   This process will take some time. Monitor the generated log file to monitor the progress.

   The process may stop several times. If you are seeing no activity in the logs for a long time, kill the process and begin again. There will be a success messaged when the entire process is done. **DO NOT** proceed until the bootstrapping has completed sucessfully.

[BACK](./install-traditional.md)
