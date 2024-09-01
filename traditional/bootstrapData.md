# Loading the database with system information

When you create a deployment environment, the **bootstrapProcessServerData** command must be completed successfully before you try to start or use Workflow Server or Workflow Center.

The following commands were used for this example.

1. Log into the BPM server as **root**.

2. Execute the following commands:

   ```sh
   cd /opt/ibm/BPM/v24.0/profiles/DmgrProfile/bin
   ./bootstrapProcessServerData.sh -clusterName SingleCluster
   ```

   This process will take some time. Monitor the generated log file to monitor the progress.
