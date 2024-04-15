# Saltstack docker container for training and testing

The image contains the master and the minion as well.

Run ``docker_image_create``

Run ``docker_container_start``

This will create an image and a container called **saltstack-docker-training**.


### You can jump into the container shell by running **docker_container_shell** or by:

``docker exec -it saltstack-docker-training /bin/bash``

## Salt commands can also be executed directly without the interactive shell:
```bash
docker exec -it saltstack-docker-training salt minion test.ping
```
```bash
minion:
    True
```

```bash
docker exec -it saltstack-docker-training salt-call test.ping
```
```bash
local:
    True
```
## Configs and states
Config files can be found in the **etc_salt** folder, while the states should be placed in **srv/salt**. Pillars and reactors should be in **srv/pillar** and **srv/reactors**.

**srv/salt** contains test.sls:
```yaml
python3:
  pkg.installed
```

```bash
docker exec -it saltstack-docker-training salt minion state.apply test
```
```bash
minion:
----------
          ID: python3
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 15:17:28.605061
    Duration: 19.419 ms
     Changes:   

Summary for minion
------------
Succeeded: 1
Failed:    0
------------
Total states run:     1
Total run time:  19.419 ms
```