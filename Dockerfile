FROM rocker/geospatial:4
COPY . /workdir

RUN Rscript -e "remotes::install_github('GlobalFishingWatch/gfwr', dependencies = TRUE)"
RUN Rscript -e "install.packages(c('dplyr','ggplot2','tidyr','sf','rnaturalearth','rnaturalearthdata'), repos='http://cran.rstudio.com')"

