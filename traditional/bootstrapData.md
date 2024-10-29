# Loading the database with system information

This section provides additional notes to supplement the [product documentation](https://www.ibm.com/docs/en/baw/24.x?topic=path-loading-database-system-information).

When you create a deployment environment, the **bootstrapProcessServerData** command must be completed successfully before you try to start or use Workflow Server or Workflow Center.

The following commands were used for this example.

1. Log into the BPM server as **root**.

2. Execute the following commands:

   ```sh
   cd /opt/ibm/BPM/v24.0/profiles/DmgrProfile/bin
   ./bootstrapProcessServerData.sh -clusterName SingleCluster
   ```

   This process will take some time. Monitor the generated log file to monitor the progress.

[BACK](./install-traditional.md)
