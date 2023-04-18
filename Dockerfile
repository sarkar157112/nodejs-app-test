# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json into the working directory
COPY package*.json ./

# Install any needed packages
RUN npm ci

# Copy the app source code into the working directory
COPY . .

# Install PM2 globally
RUN npm install -g pm2

# Create log directory for PM2 logs and set ownership to the node user
RUN mkdir -p /var/log/my-app && chown -R node:node /var/log/my-app

# Switch to the node user
USER node

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app using PM2
CMD ["pm2-runtime", "ecosystem.config.js"]
