#!/bin/bash

REGION="us-west-2"
DAYS=15
CUTOFF=$(date -u -v-"${DAYS}"d +"%Y-%m-%dT%H:%M:%SZ")

# Get all WorkSpace IDs into array
read -a IDS <<< $(aws workspaces describe-workspaces \
  --region $REGION \
  --query "Workspaces[].WorkspaceId" \
  --output text)

# Batch loop (25 per call)
for ((i=0; i<${#IDS[@]}; i+=25)); do
  BATCH=("${IDS[@]:i:25}")

  aws workspaces describe-workspaces-connection-status \
    --region $REGION \
    --workspace-ids "${BATCH[@]}" \
    --query "WorkspacesConnectionStatus[?LastKnownUserConnectionTimestamp<=\`$CUTOFF\` || LastKnownUserConnectionTimestamp==null].{WorkspaceId:WorkspaceId,LastUsed:LastKnownUserConnectionTimestamp}" \
    --output table
done
