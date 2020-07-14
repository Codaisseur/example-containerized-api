# Let's start off from the `node` container image,
#  which is like a minimal version of Linux that
#  already has node and npm installed
FROM node:12-alpine

# Create app directory inside the container
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install

# Copy the rest of the app's contents
COPY . .

# Allow communication through this port
EXPOSE 4000

# Finally, this is the command that "runs"
#  the application. It's special, in that
#  Docker will know how to restart the app
CMD [ "node", "server.js" ]
