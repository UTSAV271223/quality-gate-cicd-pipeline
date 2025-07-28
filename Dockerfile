# Base image
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy app files
COPY ./app /app

# Install dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 3000

# Run the application
CMD ["npm", "start"]
