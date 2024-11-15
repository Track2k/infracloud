# CSVServer Setup Guide

This guide explains how to set up and run the CSVServer container.

## Prerequisites

- Docker installed on your system
- Basic understanding of Docker commands
- Access to `infracloudio/csvserver` image

## Initial Setup and Troubleshooting

1. First attempt to run the container:
```
docker run infracloudio/csvserver:latest
```

This fails with the error:
```
2024/11/15 07:34:23 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory
```

The error indicates that the container requires an input file that needs to be mounted as a volume.

## Generating Input Data

Create a bash script `gencsv.sh` to generate the required input file:

```bash
#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: ./gencsv.sh <start_index> <end_index>"
    exit 1
fi

start=$1
end=$2

# Clear or create the inputFile
> inputFile

# Generate entries from start to end index
for i in $(seq $start $end); do
    random_number=$((RANDOM % 1000))
    echo "$i, $random_number" >> inputFile
done
```

Make the script executable:
```
chmod +x gencsv.sh
```

Generate the input file (example for indexes 2 to 8):
```
./gencsv.sh 2 8
```

## Running the Container

### Basic Run with Volume Mount
```
docker run -v /path-to-your/csvserver/inputdata/inputFile:/csvserver/inputdata infracloudio/csvserver
```

### Finding the Port
Access the container to check the listening port:
```
docker exec -it <container_id> bash
ss -tuln
```

### Final Configuration
Run the container with all required configurations:
```bash
docker run -d -v /path-to-your/inputdata/inputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest
```

This command:
- Runs the container in detached mode (-d)
- Mounts the input file
- Maps port 9393 on host to 9300 in container
- Sets the CSVSERVER_BORDER environment variable to Orange

## Verification

1. Check if the container is running:
```bash
docker ps
```

2. Access the application at:
```
http://localhost:9393
```

## Cleanup

To stop and remove the container:
```
docker stop <container_id>
docker rm <container_id>
```
