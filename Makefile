.PHONY: html podman-html podman-run podman-logs podman-stop

html:
	jupyter nbconvert --to=html --no-input AzDO_SNOW_AzFuncApp.ipynb

podman-html:
	podman run --rm --volume="$(shell pwd):/home/developer/jupyter:Z" --workdir="/home/developer/jupyter" --userns=keep-id localhost/jupyterlab:latest nbconvert --to=html --no-input AzDO_SNOW_AzFuncApp.ipynb

podman-build:
	podman build -f JupyterLab.DevContainer.containerfile -t localhost/jupyterlab:latest .

podman-run:
	podman run --rm --detach --name="jupyter-lab" --hostname="jupyter-lab" --volume="$(shell pwd):/home/developer/jupyter:Z" --publish 127.0.0.1:8888:8888 --workdir="/home/developer/jupyter" --userns=keep-id localhost/jupyterlab:latest

podman-logs:
	podman logs jupyter-lab

podman-stop:
	podman stop jupyter-lab
