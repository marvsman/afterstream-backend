FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci

# Install curl for healthchecks (required by Coolify)
RUN apk add --no-cache curl

COPY . .

RUN npx prisma generate

RUN npm run build

EXPOSE 3000

CMD ["sh", "-c", "npx prisma migrate deploy && node .output/server/index.mjs"]
