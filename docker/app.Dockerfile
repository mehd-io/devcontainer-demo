FROM python:3.8-slim

ENV PORT=8080
WORKDIR /app

COPY . /app
RUN apt-get update \
    && apt-get install --no-install-recommends -yq make gcc libpq-dev libffi-dev libtool \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Pinning version bc : https://github.com/pypa/pipenv/issues/4220
RUN pip install pipenv==2018.11.26 --no-cache-dir \
    && pipenv install --deploy --system --dev

EXPOSE ${PORT}

CMD exec uvicorn --host 0.0.0.0 --port ${PORT} devcontainer_demo.main:app