#TODO
#!/bin/bash

# Define Variables
namespace="sre"
deployment_name="swype-app"
max_restarts=5

# Start Infinite Loop
while true; do
    # Check Pod Restarts
    restarts=$(kubectl get pods -n $namespace -l app=$deployment_name -o jsonpath='{.items[*].status.containerStatuses[*].restartCount}')

    
    # Display Restart Count
    echo "Current restart count: $restarts"
    
    # Check Restart Limit
    if [[ $restarts -gt $max_restarts ]]; then
        # Scale Down if Necessary
        echo "Number of restarts exceeds maximum allowed. Scaling down deployment."
        kubectl scale deployment $deployment_name --replicas=0 -n $namespace
        break
    fi
    
    # Pause for 60 seconds
    echo "Pausing for 60 seconds before next check..."
    sleep 60
done
