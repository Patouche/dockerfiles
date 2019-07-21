# Latex

Docker image to build LaTeX presentation.

## Usage :

```bash
# To run this image, you can use 
docker run \
    patouche/latex

# To install extra latex packages on start, set a file name tex.packages
docker run \
    -v tex.packages:/opt/latex/tex.packages \
    patouche/latex

# To compile a tex file,
docker run \
    -v $(pwd):/opt/latex/ \
    patouche/latex
    pdflatex \
        -halt-on-error \
        --output-directory /opt/latex/build /opt/latex/build/test.tex
```

