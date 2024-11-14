# Traditional Install

The final configuration will be a single node cluster for BAW with an external DB2 instance hosting the BAW databases.

The virtual maching used to host BAW is using the following:

* CPUs: 8
* Memory: 16 GB
* Storage: 40GB
* OS: RHEL9 configured as server with GUI

BAW V24.x is being installed. The following base directory structure is being used.

* **/opt/install** : the BAW installation files from the _tar.zg_ files
* **/opt/ibm/BAW** : target base directory for BAW install

The nonroot user for installation is **wasadmin**.

The external database instance owner is **db2inst1**. The external database user that BAW will need to access the databases is **db2admin**.

The following steps provide details on the installation process. Refer to the [IBM Business Automation Workflow documentation](https://www.ibm.com/docs/en/baw/24.x) for the complete process.

* [Preparing operating systems for product installation](https://www.ibm.com/docs/en/baw/24.x?topic=software-preparing-operating-systems-product-installation)
  * [Preparing Linux systems for installation](./linux_os_prep.md)
* [Installing and configuring IBM Business Automation Workflow](https://www.ibm.com/docs/en/baw/24.x?topic=configuring-installing-business-automation-workflow)
  * [On AIX or Linux](https://www.ibm.com/docs/en/baw/24.x?topic=workflow-aix-linux)
    * [Using a custom installation and configuration path](https://www.ibm.com/docs/en/baw/24.x?topic=linux-using-custom-installation-configuration-path)
      * [Installing IBM Business Automation Workflow](https://www.ibm.com/docs/en/baw/24.x?topic=path-installing-business-automation-workflow)
        * [Installing silently with a response file](./response_file_install.md)
      * [Granting write permission of files and directories to nonroot users](https://www.ibm.com/docs/en/baw/24.x?topic=path-granting-write-permission-files-directories-nonroot-users)
      * [Configuring profiles and creating a network deployment environment](https://www.ibm.com/docs/en/baw/24.x?topic=path-configuring-profiles-creating-network-deployment-environment)
        * [For DB2](https://www.ibm.com/docs/en/baw/24.x?topic=environment-db2)
          * [Using the BPMConfig command](https://www.ibm.com/docs/en/baw/24.x?topic=db2-using-bpmconfig-command)
            * [Creating DB2 databases](./createDatabases.md)
            * [Creating profiles, network deployment environments and database tables using BPMConfig](./createProfiles.md)
            * [Running the generated database scripts](https://www.ibm.com/docs/en/baw/24.x?topic=command-running-generated-database-scripts)
      * [Loading the database with system information](./bootstrapData.md)
  * [Starting your environment and verifying the installation](./start-stop.md)
