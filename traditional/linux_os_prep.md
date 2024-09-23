# Preparing Linux systems for installation

This section provides additional notes to supplement the [product documentation](https://www.ibm.com/docs/en/baw/24.x?topic=installation-preparing-linux-systems).

* Increase the allowable stack size, number of open files, number of processes, and file size. Add the following lines to the end of the _/etc/security/limits.conf_ file, or if the lines already exist, change the values. In this implementation, the _wasadmin_ account will be executing BAW.

    ```text
    # - stack - maximum stack size (KB)
    wasadmin soft stack 32768
    wasadmin hard stack 32768
    # - nofile - maximum number of open files
    wasadmin soft nofile 65536
    wasadmin hard nofile 65536
    # - nproc - maximum number of processes
    wasadmin soft nproc 16384
    wasadmin hard nproc 16384
    # - fsize - maximum file size
    wasadmin soft fsize 6291453
    wasadmin hard fsize 6291453
    ```

* Set the **umask** value to **077** using the following command:

    ```sh
    umask 077
    ```

   The value 077 is the most restrictive value that IBM Business Automation Workflow tolerates. You can choose to set a less restrictive umask value for the following access levels. This is optional.

  * _037_ for read-only access for a group of human administrators and tools
  * _027_ for read and write access for a group of human administrators and tools
  * _007_ for read, write, and execute access for a group of human administrators and tools

* Restart the VM
