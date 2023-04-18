# Dockerfile
# Use the official Node.js image as the base image
FROM node:14 as build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package*.json to the working directory
COPY package*.json ./

# Install the application's dependencies
RUN npm ci

# Copy the application's source code to the working directory
COPY . .

# Use a smaller, more secure base image for the runtime environment
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy only the production dependencies and the built app from the build stage
COPY --from=build /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=build /usr/src/app/app.js /usr/src/app/app.js
COPY --from=build /usr/src/app/process.yml /usr/src/app/process.yml

# Install PM2
RUN npm install -g pm2

# Create log directory for PM2 logs and set ownership to the node user
RUN mkdir -p /var/log/pm2 && chown -R node:node /var/log/pm2

# Switch to the node user
USER node


# Expose the application's port
EXPOSE 3000

# Start the application with PM2
CMD ["npx", "pm2-runtime", "start", "process.yml"]
