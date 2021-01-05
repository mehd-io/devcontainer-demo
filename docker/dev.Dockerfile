#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

# Update the VARIANT arg in devcontainer.json to pick a Python version: 3, 3.8, 3.7, 3.6 
ARG VARIANT=3
FROM python:${VARIANT}-slim

# Default set of utilities to install in a side virtual env
ARG DEFAULT_UTILS="\
    pylint \
    flake8 \
    autopep8 \
    black \
    pytest \
    yapf \
    mypy \
    pydocstyle \
    pycodestyle \
    bandit \
    poetry "

# Options for common package install script
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"

# Copy docker scripts
COPY docker/library-scripts/common-debian.sh /tmp/library-scripts/

# Configure apt and install packages
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    # Remove imagemagick due to https://security-tracker.debian.org/tracker/CVE-2019-10131
    && apt-get purge -y imagemagick imagemagick-6-common \
    # Install common packages, non-root user
    && bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/library-script \
    # Setup default python tools 
    && echo "${DEFAULT_UTILS}" | xargs -n 1 python -m pip install --no-cache-dir  


CMD [ "sleep", "infinity" ]