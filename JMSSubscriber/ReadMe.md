# JMSSubscriber Template

This DB Query template provides an integration pattern for running a DB Query from a sub process. The top level can be configured for any type of transport. Error Handling is already set up.

## Initial setup

- Follow generic developer setup instructions in the Templates [../ReadMe.md]
- Run the following to create the initial Workspace and import the CommonUtils Shared Module

    `init.sh <ApplicationName> <DockerImageName>`

    where

        <ApplicationName> is a meaningful name for the logical application. It should be Mixed Case with a capitalised first letter

        <DockerImageName> is a meaningful name for the docker image that is deployed. It should essentially be the same meaningful name as the Application Name but all lower case and using a hyphen (-) as a logical separator. 

    e.g. `init.sh AssetsService asset-service`

## Setup in Studio and Adding Business Logic

- Open the newly created Workspace in Studio
- Right click on the Application Module and select Rename. Add the logical name for the application
- Right click on the Application and select Rename. Add the logical name for the application with a .application suffix
- In the DBQuery subprocess, add your SQL Statement in the Statement tab of the DBQuery activity and select Fetch
- If you have any parameters in the SQL Statement, add them as question marks and add a corresponding parameter in the parameter list below
- If you have any parameters, map them in the Input Editor
- Add a schema in the Input Editor tab of the MapResponse activity and map the input in the Input tab
- Repeat the previous step for the End activity. Note that best practice here is to have the same schema on the MapResponse and End activities and just do a "CopyOf" for the mappings
- Add transport logic and any other business logic as appropriate

## Status 

Work in Progress