# Installing silently with a response file

The following response file will be used to install BAW.

* [CIGNA workflow Enterprise 64 bit Linux nonroot response file](./CIGNA_workflowEnterprise_linux_response_nonroot_64bit.xml)

The following commands wikk be executed for the install:

```sh
cd /opt/install/responsefiles/BPM
/opt/install/IM64/userinstc -acceptLicense input /opt/install/responsefiles/BPM/CIGNA_workflowEnterprise_linux_response_nonroot_64bit.xml -log /opt/install/log/silent_install.log -dataLocation /opt/ibm/BPM/IMData

```

The response will be similar to the following:

```text
Modified com.ibm.cic.agent_1.9.1002.20200325_1842 in the /home/wasadmin/IBM/InstallationManager/eclipse directory.
Installed com.ibm.websphere.ND.v85_8.5.5025.20240119_0940 to the /opt/ibm/BPM/v24.0 directory.
Installed 8.5.5.23-WS-WAS-IFPH59117_8.5.5023.20240408_1446 to the /opt/ibm/BPM/v24.0 directory.
Installed 8.5.5.0-WS-WAS-IFPH60850_8.5.5000.20240510_0414 to the /opt/ibm/BPM/v24.0 directory.
Installed 8.5.5.10-WS-WASProd-IFPH61002_8.5.5010.20240419_1214 to the /opt/ibm/BPM/v24.0 directory.
Installed 8.5.5.25-WS-WAS-IFPH59781_8.5.5025.20240229_0721 to the /opt/ibm/BPM/v24.0 directory.
Installed 8.5.5.24-WS-WAS-DistOnly-IFPH61385_8.5.5024.20240520_1642 to the /opt/ibm/BPM/v24.0 directory.
Installed com.ibm.bpm.ADV.v85_8.6.70024000.20240613_1535 to the /opt/ibm/BPM/v24.0 directory.
CRIMA1269W WARNING: This installation operation did not modify the installation at "/home/wasadmin/IBM/InstallationManager/eclipse".

Explanation: The package, features, and languages specified by this operation are already installed at this location.

User Action: No action is required unless you expected something different. If one of the elements is incorrect - the package group, package ID, directory, features, or languages - change the information and run the operation again. If the package is already installed and you intended to reinstall it from scratch, uninstall the package before you reinstall.

```

After you install Business Automation Workflow, you must configure the product by creating profiles, setting up database tables, and configuring the network deployment environment.