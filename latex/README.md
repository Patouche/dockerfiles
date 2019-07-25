# Latex

Docker image to build LaTeX presentation.

## Usage :

```bash
# To run this image, you can use 
docker run --rm -ti \
    patouche/latex \
    bash

# To install extra latex packages on start, set a file name tex.packages
docker run --rm -ti \
    -v tex.packages:/latex/tex.packages \
    patouche/latex \
    bash

# To compile a tex file,
docker run --rm -ti \
    -v $(pwd):/latex/ \
    patouche/latex
    pdflatex \
        -halt-on-error \
        --output-directory /latex/build /latex/build/test.tex
```

