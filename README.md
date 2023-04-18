# Nodejs App with multi-stage Dockerfile and Side-Car Reverse-Proxy
Create a new directory for your Node.js application and navigate to it:
# mkdir sample-node-app
# cd sample-node-app
Initialize the project and create a package.json file by running:
# npm init -y
Install Express and PM2 as dependencies:
# npm install express pm2
Create an app.js file in the project directory and add the following code
# check in the code 
Create a process.yml file in the project directory for PM2 configuration:
# process.yml
apps:
  - script: app.js
    name: sample-node-app
    instances: 1
    exec_mode: cluster
    env:
      NODE_ENV: production
Create a Dockerfile in the project directory with the following content:
# check Dockerfile
Build the Docker image by running the following command in the project directory:
# docker build -t sample-node-app .
Once the image is built, you can run the container with the following command:
# docker run -it --name sample-node-app -p 3000:3000 sample-node-app
=======================================================================================================================================

Now, the sample Node.js application should be running inside a Docker container managed by PM2 and accessible at http://localhost:3000.

what is npx
npx is a command-line utility that is included with npm (Node.js Package Manager) starting from version 5.2.0. It is designed to make it easier to run and manage Node.js executables from npm packages. npx allows you to:

Execute a locally installed package without specifying the full path to the package's binary.
Run a package that is not installed locally by downloading and executing it in a single command.
Execute a specific version of a package by specifying the version number.
Test different versions of a package without installing them globally.
When you run npx followed by a package name, it first looks for the package in your local node_modules/.bin directory. If the package is not found locally, npx will download the package from the npm registry, run the specified command, and then remove the package to avoid cluttering your system.

For example, in the Dockerfile provided in the previous answer, the following command is used to start the application with PM2:

# CMD ["npx", "pm2-runtime", "start", "process.yml"]
This command uses npx to run the pm2-runtime script, which is part of the locally installed PM2 package. By using npx, you don't have to provide the full path to the PM2 binary, making the command more concise and easier to maintain.






