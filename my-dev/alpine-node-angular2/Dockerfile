FROM node:8-alpine

MAINTAINER Candido H T

# Install bash
RUN apk add --update bash && rm -rf /var/cache/apk/*

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install 

# Bundle app source 
COPY . /usr/src/app 

EXPOSE 4200 
CMD [ "npm", "start" ]