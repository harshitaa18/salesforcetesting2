#!/bin/bash
# Deploy only the working deploymentTracker component
sf project deploy start --target-org staging-org --source-dir force-app/main/default/lwc/deploymentTracker
