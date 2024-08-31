# Traditional Install

The final configuration will be a single node cluster for BAW with an external DB2 instance hosting the BAW databases.

The virtual maching used to host BAW is using the following:

* CPUs: 8
* Memory: 8 GB
* Storage: 40GB
* OS: RHEL9 configured as server with GUI

BAW V24.x is being installed. The following base directory structure is being used.

* **/opt/install** : the BAW installation files from the _tar.zg_ files
* **/opt/ibm/BAW** : target base directory for BAW install

The following steps provide details on the installation process. Refer to the [IBM Business Automation Workflow documentation](https://www.ibm.com/docs/en/baw/24.x) for the complete process.

* Preparing operating systems for product installation
  * [Preparing Linux systems for installation](./linux_os_prep.md)
* Installing and configuring IBM Business Automation Workflow
  * On AIX or Linux
    * Using a custom installation and configuration path
      * Installing IBM Business Automation Workflow
        * [Installing silently with a response file](./response_file_install.md)
      * [Granting write permission of files and directories to nonroot users](./nonroot_permissions.md)
      * Configuring profiles and creating a network deployment environment
        * For DB2
          * Using the BPMConfig command
            * Creating DB2 databases
            * Creating profiles, network deployment environments and database tables using BPMConfig
            * Running the generated database scripts
      * Loading the database with system information
