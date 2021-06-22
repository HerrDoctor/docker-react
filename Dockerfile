# DOCKER IMAGE FOR SIMPLEWEB
#
# MULTI-STEP BUILD PROCESS
#
# PHASE 1: 'Build' step
#
# Use an existing docker image as a base

# Using a custom name
#FROM node:alpine as builder
# No custom name: (stage number 0)
FROM node:alpine

USER node

# Establishing working directory
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# (Optional) Download extra utilities to customize our base image

# Adding and installing project dependencies
COPY --chown=node:node package.json .
RUN npm install

# Adding project files to the working directory
COPY --chown=node:node . .

# Building the production server
RUN npm run build

# Exposing ports

# Tell the image what to do when it starts as a container



# PHASE 2: 'Run' step
#
# Use an existing docker image as a base
FROM nginx

#USER node

# Exposing ports
EXPOSE 80

# Establishing working directory
WORKDIR /app

# (Optional) Download extra utilities to customize our base image

# Adding project files to the working directory
# Using a custom name
#COPY --from=builder /home/node/app/build /usr/share/nginx/html
# No custom name: (stage number 0)
COPY --from=0 /home/node/app/build /usr/share/nginx/html

# Tell the image what to do when it starts as a container
