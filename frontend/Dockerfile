FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy source files
COPY . .

# Build arguments for environment variables
ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

# Build the application
RUN npm run build

# Step 2: Serve using nginx
FROM nginx:alpine

# Install gettext for envsubst
RUN apk add --no-cache gettext

# Set default environment variables
ENV BACKEND_HOST=backend
ENV BACKEND_PORT=8080

# Copy built files
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx template and startup script
COPY ./nginx.conf.template /etc/nginx/templates/
COPY ./start-nginx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-nginx.sh

EXPOSE 80

# Use the startup script instead of directly starting nginx
CMD ["/usr/local/bin/start-nginx.sh"]
