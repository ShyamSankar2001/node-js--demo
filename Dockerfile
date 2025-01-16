# Stage 1: Build Stage
FROM node:22-alpine AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install the dependencies (including dev dependencies)
RUN npm install

# Copy the rest of the application code into the container
COPY . .


# Stage 2: Final Stage (Runtime Image)
FROM node:22-alpine AS runtime

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy only the necessary files from the build stage (dependencies and built code)
COPY --from=build /usr/src/app /usr/src/app

# Install only production dependencies (to reduce image size)
RUN npm install --production

# Expose port 3000 for the app to be accessed externally
EXPOSE 3000

# Command to run the Node.js application
CMD ["npm", "start"]
