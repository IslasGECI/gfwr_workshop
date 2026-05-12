FROM rocker/geospatial:4
COPY . /workdir

RUN Rscript -e "install.packages(c('dplyr', 'ggplot2', 'remotes', 'rnaturalearth', 'rnaturalearthdata', 'sf', 'tidyr'), repos='http://cran.rstudio.com')"
RUN Rscript -e "remotes::install_github('GlobalFishingWatch/gfwr', dependencies = TRUE)"

