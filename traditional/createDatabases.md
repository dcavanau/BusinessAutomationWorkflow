# Create DB2 Databases

This section provides additional notes to supplement the [product documentation](https://www.ibm.com/docs/en/baw/24.x?topic=command-creating-db2-databases).

The required databases will created the required databases for IBM® Business Automation Workflow after running the **BPMConfig** command with the **-create -de** parameters to create profiles and configure the deployment environment.

The **BPMConfig** command requires input from a properties file that contains configuration settings for the profiles, deployment environment, and databases to be created. In this file, the **bpm.de.deferSchemaCreation** property determines when the databases can be created:

* If the property is set to **false**, database tables are automatically created when you run the **BPMConfig** command to create the profiles and deployment environment. Therefore, the empty databases must exist before you run the **BPMConfig** command.

* If the property is set to **true**, database table creation is deferred when you run the **BPMConfig** command to create the profiles and deployment environment. Therefore, you can create the databases either before or after running the command. You might find it useful to create the databases after running the **BPMConfig** command because you can use the set of populated scripts, which the command generates, to create the databases and database tables at a time that you choose.

In this example, the **bpm.de.deferSchemaCreation** property will be set to **true**.

The default database names are **BPMDB** for the Process database, **PDWDB** for the Performance Data Warehouse database, **CMNDB** for the Common database, and **CPEDB** for the Content database. The Process and Performance Data Warehouse require their own separate databases and cannot be configured on the same database as the other IBM Business Automation Workflow components.

To generate the database scripts that can be used by the **BPMConfig** command to create and configure your databases, you can run **BPMConfig** with the **-create -sqlfiles** parameters, and additionally include the **-outputDir** parameter to specify a location for the generated scripts. When you run the **BPMConfig** command with these parameters, it generates the database scripts without configuring your environment.

The configuration properties file used for this example is [CIGNA Advanced Process Center Signle Cluster DB2](./CIGNA-Advanced-PC-SingleCluster-DB2.properties).

1. Execute the following commands on the BPM Virtual Machine as _root_:

   ```sh
   cd /opt/ibm/BPM/v24.0/bin/
   mkdir /opt/install/dbfiles

   ./BPMConfig.sh -create -sqlfiles /opt/install/CIGNA-Advanced-PC-SingleCluster-DB2.properties -outputDir /opt/install/dbfiles/
   ```

   [Here are the generated database scripts](./dbfiles/)

2. On the DB2 server, create a user account for **db2admin**

   ```sh
   useradd db2admin
   passwd db2admin
   ```

3. Copy the files on the BPM Server from **/opt/install/dbfiles** to the DB2 Server **/home/db2inst1/dbfiles**.

4. Log into the DB2 server as user **db2inst1** and execute the following commands to create the databases:

   ```sh
   cd /home/db2inst1/dbfiles/PCCell1.De1/DB2/CMNDB
   ./createDatabase.sh
   db2 connect to CMNDB USER db2admin USING Think4me
   db2 -tvf createSchema_Advanced.sql
   db2 -tvf createSchema_Messaging.sql
   db2 connect reset

   cd /home/db2inst1/dbfiles/PCCell1.De1/DB2/BPMDB
   ./createDatabase.sh
   db2 connect to BPMDB USER db2admin USING Think4me
   db2 -tvf createSchema_Advanced.sql
   db2 -tdGO -vf createProcedure_Advanced.sql
   db2 connect reset

   cd /home/db2inst1/dbfiles/PCCell1.De1/DB2/PDWDB
   ./createDatabase.sh
   db2 connect to PDWDB USER db2admin USING Think4me
   db2 -tvf createSchema_Advanced.sql
   db2 connect reset

   cd /home/db2inst1/dbfiles/PCCell1.De1/DB2/CPEDB
   ./createDatabase_ECM.sh
   db2 connect to CPEDB USER db2admin USING Think4me
   db2 -tvf createSchema_Advanced.sql
   db2 -tvf createTablespace_Advanced.sql
   db2 connect reset
  
   ```
