# Latex

Docker image to build LaTeX presentation.

## Usage :

```bash
docker run patouche/latex
```

## Build :

Locally, you can build and test image with the following command line :

```bash
export IMG_DOCKER_TAG=latex
docker build -t ${IMG_DOCKER_TAG} .
./test.dockerimg.sh ${IMG_DOCKER_TAG}
```
