# vim: ft=dockerfile

# A build Argument available to the FROM statement.
# Allows builders to override the Python version. However, this Containerfile
# is designed to be used with Debian based images.
ARG PYTHON_VERSION=bullseye

# Pull the Container Image from Docker Hub.
FROM docker.io/library/python:bullseye

# Install OS Packages to allow Jupyter Lab to run and export files.
RUN apt update && \
    apt install --yes \
      graphviz \
      inkscape \
      pandoc \
      texlive-xetex \
      texlive-fonts-recommended \
      texlive-plain-generic

# Install Python Libraries.
RUN python3 -m pip install \
      jupyterlab \
      graphviz \
      pyppeteer \
      nbconvert \
      pandas \
      matplotlib

# Create a non-root user to run Jupyter Lab as.
RUN groupadd developer && \
    useradd -m -s /bin/bash -d /home/developer -g developer developer
# This is because Docker LSP sees comments in a RUN block as an error.
# && \
# echo "%developer ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/developer && \
# chmod 440 /etc/sudoers.d/developer

USER developer
WORKDIR /home/developer

# This makes the container an executable. If a shell session is desired, then
# the user would need to override the entrypoint of the container.
ENTRYPOINT ["/usr/local/bin/jupyter"]

# These can be overridden when the container is ran. These can also be defined
# as part of the ENTRYPOINT, but I chose to put them in the CMD to also display
# the capability.
CMD ["lab", "--ip=0.0.0.0", "--no-browser"]

# This allows the user to run the container using predefined options.
#
#     podman container runlabel --display run localhost/jupyterlab:latest
#
#     podman container runlabel run localhost/jupyterlab:latest
#
# You can see the command being ran by using the --display flag before the image
# name. Doing this won't actually run the container. Other labels can be
# provided as well to provide different commands.
LABEL RUN="podman run --rm --name=\"jupyter-lab\" --hostname=\"jupyter-lab\" --userns=keep-id --volume=\"$(pwd):/home/developer/jupyer:Z\" --workdir=\"/home/developer/jupyter\" --publish=\"127.0.0.1:8888:8888\" localhost/jupyterlab:latest"
