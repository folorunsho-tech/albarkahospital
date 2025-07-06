# Use the official Node.js runtime as the base image
FROM node:lts-alpine3.21

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm ci && npm cache clean --force

# Copy the rest of the application code
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Create a non-root user to run the application
RUN addgroup -g 1001 -S nodejs
RUN adduser -S expressuser -u 1001

# Change ownership of the app directory to the non-root user
RUN chown -R expressuser:nodejs /app
USER expressuser

# Expose the port the app runs on
EXPOSE 8000

# Define the command to run the application
CMD ["node", "index.js"]