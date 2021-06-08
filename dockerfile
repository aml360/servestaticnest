FROM node
# Create app directory

WORKDIR /app

COPY package*.json ./

COPY . .

EXPOSE 3000

CMD [ "npm", "run", "start:prod-compiled" ]
