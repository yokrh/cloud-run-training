FROM node:10

WORKDIR /src

ENV PORT 8080
ENV HOST 0.0.0.0

COPY . .

# RUN npm install --production  # failed by loading eslint specified at buildModule in nuxt.config.js
RUN npm install

RUN npm run build

CMD ["npm", "run", "start"]
