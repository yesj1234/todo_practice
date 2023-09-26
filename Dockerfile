FROM node:18-alpine as dev
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY --chown=node:node package*.json ./
ENV NODE_ENV development
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:18-alpine as build
RUN apk add --no-cache libc6-compat
WORKDIR /app
ENV NODE_ENV production
COPY --chown=node:node --from=dev /app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build
RUN npm ci --only=production && npm cache clean --force  
USER node 

FROM node:18-alpine as prod
WORKDIR /app
RUN apk add --no-cache libc6-compat
ENV NODE_ENV production
COPY --chown=node:node --from=build /app/dist/ dist
COPY --chown=node:node --from=build /app/node_modules node_modules
USER node
CMD ["node", "dist/main.js"]