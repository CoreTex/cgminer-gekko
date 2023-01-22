#!/bin/bash
docker stop soloCK && docker rm soloCK && docker system prune -f && docker run --name soloCK -d -t -i --privileged -v /dev/bus/usb:/dev/bus/usb $(docker build . | grep "Successfully built " | awk -F ' ' '{print $3}') -u bc1qftcrayx6d5hh88h0nl04nyjj6kwge5m92u4pm2.0 -p x -o stratum+tcp://solo4.ckpool.org:3333  --gekko-newpac-freq 1200 --worktime && docker logs -f soloCK
