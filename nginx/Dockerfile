FROM nginx:alpine
## Copy a new configuration file setting listen port to 8080
RUN rm -rf /etc/nginx/conf.d/default.conf
RUN rm -rf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN chown -R nginx:nginx /usr/share/nginx/html/
RUN chmod -R 544  /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
