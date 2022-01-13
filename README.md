# jupyterlab-devcontainer

## Overview

A Jupyer Lab DevContainer.

## Setup

Build the Container Image

```bash
podman build -f JupyterLab.DevContainer.containerfile -t localhost/jupyterlab:latest .
```

The resulting image is a bit big, but it's a DevContainer.
When running on a server or in a container orchestration cluster, it should work just fine.

```bash
$ podman image ls        
REPOSITORY                                 TAG                   IMAGE ID      CREATED            SIZE
localhost/jupyterlab                       latest                058ef6c58671  58 minutes ago     2.46 GB
```

## Usage

Setup a Volume or use a Bind Mount to save development files and such.

You can also use a `podman container runlabel` command to run the container, but it doesn't persist any data when the container is stopped.
