#base image
FROM node:22-alpine

#current directory inside container
WORKDIR /usr/src/app

#copy files from local to container
COPY package*.json app.js ./

#install the dependencies
RUN npm install

#expose the port
EXPOSE 3000

#start the nodejs app
CMD ["npm", "start"]
