# Devcontainer demo (Python API)
This is a simple demo using the powerful [Remote containers](https://code.visualstudio.com/docs/remote/containers) feature from VS Code to enable your full development environment containerized.

Requirements :
* Docker
* VS Code
* Remote Container extension
* .ssh folder in your home dir (or remove the section `mount` in `.devcontainer/devcontainer.json` as otherwise it will failed when launching)

Tested on MacOs.

VS Code will prompt a window to suggest you to open the project in a container or you can use the command `Remote-containers:Reopen in container`

The project is a simple fastapi project with one endpoint.


# Tests
```
pytest
```