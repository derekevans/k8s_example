
FROM ubuntu:22.04

RUN apt-get update

# Necessary for installing tzdata non-interactively
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install tools 
RUN apt-get install software-properties-common tzdata wget -y

# Install python3.11
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update -y && \
    apt-get install python3.11 python3.11-venv python3.11-dev python3.11-distutils libffi-dev -y

# Create ubuntu user, switch to this user, and cd to user home directory
RUN useradd --create-home --shell /bin/bash ubuntu
USER ubuntu
ENV HOME=/home/ubuntu
WORKDIR $HOME

# Install venv
RUN python3.11 -m venv ~/python/envs/venv

# Enable venv
ENV PATH="/home/ubuntu/python/envs/venv/bin:$PATH"

RUN pip install Flask

COPY app.py app.py

CMD flask run --host 0.0.0.0