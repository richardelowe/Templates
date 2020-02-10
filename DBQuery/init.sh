#!/bin/bash
if test "$#" -ne 2; then
    echo "Incorrect number of parameters"
    echo "Usage:init.sh <ApplicationName> <DockerImageName>"
    echo "  <ApplicationName> is a meaningful name for the application. It should be Mixed Case with a capitalised first letter"
    echo "  <DockerImageName> is a meaningful name for the docker image that is deployed. It should essentially be the same meaningful name as the Application Name but all lower case and using a hyphen (-) as a logical separator. "
    exit 2
fi

# Set location of the TIBCO product folders with no trailing slashes
export TIBCO_HOME=/opt/tibco/bwce251
export STUDIO_HOME=$STUDIO_HOME/studio/4.0/eclipse/TIBCOBusinessStudio.app/Contents/MacOS
export BW_HOME=$TIBCO_HOME/bwce/2.5
export STUDIO_EXEC=$STUDIO_HOME//opt/tibco/bwce251/studio/4.0/eclipse/TIBCOBusinessStudio.app/Contents/MacOS
# Add the BW bin directory to the path as the bwdesign command also needs to know where the bwdesign.tra file is
export PATH=$PATH:$BW_HOME/bin
# Absolute or relative path to Workspaces
export WORKSPACE_PATH=../../Workspaces
# Absolute or relative path to Projects
export PROJECT_PATH=../../Projects
# Name of CommonUtils project
export COMMON_UTILS=Common/CommonUtils
# This template
export TEMPLATE=DBQuery

#Create variables for Workspace, Application Module and Application
export LOGICAL_APP_NAME=$1
export DOCKER_IMAGE_NAME=$2
export WORKSPACE=$WORKSPACE_PATH/$LOGICAL_APP_NAME
export NEW_PROJECT_PATH=$PROJECT_PATH/$LOGICAL_APP_NAME
export APP_MODULE_PATH=$NEW_PROJECT_PATH/$LOGICAL_APP_NAME
export APP_NAME=$LOGICAL_APP_NAME.application
export APP_PATH=$NEW_PROJECT_PATH/$APP_NAME
export TEMPLATE_APP=$TEMPLATE.application
export COMMON_UTILS_PATH=$PROJECT_PATH/$COMMON_UTILS

# Create a new directory to act as the temporary build Workspace
mkdir $WORKSPACE
# Creae a new directory to house the projects
mkdir $NEW_PROJECT_PATH
# Copy the templates projects to the new directory to house the projects
cp -R $TEMPLATE $APP_MODULE_PATH
cp -R $TEMPLATE_APP $APP_PATH

# If required, you could also import Workspace preferences, e.g. copy from an existing Workspace
# example command would be: $BW_HOME/bin/bwdesign system:importpreferences <preference file>

# Import the application module and application into the new Workspace
# You could also add Shared Modules if required
# Multiple comma-separated directories can be added
# Zips can be used instead of directories with differents flags
# Check the bwdesign help for details
# https://docs.tibco.com/pub/activematrix_businessworks/6.6.0/doc/html/GUID-48418693-540D-4164-AF9A-C2F8DF4F0A12.html
bwdesign -data $WORKSPACE system:import $APP_MODULE_PATH,$APP_PATH,$COMMON_UTILS_PATH
RESULT=$?

if [ $RESULT -eq 0 ]; then
  echo "bwdesign project import succeeded"
else
  echo "bwdesign project import failed"
  exit 1
fi

# Open studio
# $STUDIO_EXEC

exit 0

