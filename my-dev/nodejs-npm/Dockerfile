FROM alpine:edge

#Install NodeJs
RUN apk add --no-cache nodejs bash npm

# Prepare app directory
RUN mkdir -p /src/

# Install dependencies
WORKDIR /src/

VOLUME ["/src"]

# Expose the app port
EXPOSE 8000

CMD [ "node" ]