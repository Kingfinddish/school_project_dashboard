# Use Node.js as the base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Generate Database
# RUN npx prisma migrate dev --name init
# remove the above code because it caused error and added the one below. instead run it like this and in vps terminal execute afterward: docker compose exec app npx prisma migrate dev --name init

# Generate Prisma client (safe to run during build)
RUN npx prisma generate

# Build the Next.js application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Start the Next.js application
CMD ["npm", "start"]