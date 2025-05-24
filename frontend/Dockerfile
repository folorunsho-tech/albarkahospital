# Step 1: Build the application
FROM node:24.0-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy all files
COPY . .

# Build the Next.js app
RUN npm run build

# Step 2: Run the application with a lightweight server
FROM node:24.0-alpine AS runner

# Install production dependencies only
COPY package.json package-lock.json ./
RUN npm ci 
WORKDIR /app

# Copy built files from builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/next.config.js ./next.config.js

# Expose port
EXPOSE 8080

# Start the application
CMD ["npm", "start"]