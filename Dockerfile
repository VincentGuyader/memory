FROM rocker/tidyverse:3.5.1
RUN R -e "install.packages('pacman')"
RUN R -e "pacman::p_load('remotes')"
RUN R -e "pacman::p_load('prettyunits')"
RUN R -e "pacman::p_load('pryr')"
RUN R -e "pacman::p_load('shiny')"
RUN R -e "pacman::p_load('nessy')"
RUN R -e "remotes::install_github('vincentguyader/memory')"

EXPOSE 3838
CMD ["R", "-e options('shiny.port'=3838,shiny.host='0.0.0.0');memory::run_app()"]