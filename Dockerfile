# syntax=docker/dockerfile:1

# Build the frontend in a Node image so Node isn't needed at runtime
FROM node:24-slim AS micboard_frontend
WORKDIR /home/node/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM python:3.13-slim AS micboard_server

LABEL maintainer="Will Jarrell <wjarrell@crossings.church>"

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y --no-install-recommends libheif-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY py/requirements.txt py/requirements.txt
RUN pip3 install --no-cache-dir -r py/requirements.txt

COPY . .
COPY --from=micboard_frontend /home/node/app/static /usr/src/app/static/

EXPOSE 8058

CMD ["python3", "py/micboard.py"]
