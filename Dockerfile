FROM ubuntu:bionic

# install latex packages
RUN apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-xetex \
    texlive-science \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern

# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
ENV PANDOC_VERSION "2.9.2"

RUN apt-get install -y wget
RUN wget https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-1-amd64.deb && dpkg -i pandoc-$PANDOC_VERSION-1-amd64.deb

WORKDIR /source

ENTRYPOINT ["/usr/bin/pandoc"]

CMD ["--help"]