# Dockerfile for Next.js app
FROM node:20-alpine AS base
WORKDIR /app

ENV NODE_ENV=production

COPY package.json package-lock.json* ./
COPY prisma/schema.prisma ./prisma/

RUN npm ci --production=false

COPY . .

RUN npm run prisma:generate
RUN npm run db:push
RUN npm run prisma:seed

RUN npm run build

EXPOSE 3000

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s CMD curl -f http://localhost:3000/api/health || exit 1

CMD ["npm", "run", "start"]
