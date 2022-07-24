# get the base node image
FROM node:14.15.0 AS builder

# set the working dir for container
WORKDIR /contact-list-app

# copy the json file first
COPY package.json /contact-list-app

# install npm dependencies
RUN npm install

# copy other project files
COPY . .

# build the folder
RUN npm run build

# Handle Nginx
FROM nginx
COPY --from=builder /contact-list-app/build /usr/share/nginx/html
COPY ./docker/nginx/default.conf /etc/nginx/default.conf
