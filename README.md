# docker-yii2-nginx
Dockerize Yii2 app using nginx web server


### fixes
If you get the permission denied error on the entrypoint.sh file, check that this file has the executable permission if you're building from under Linux, or add the RUN chmod +x /etc/entrypoint.sh to the Dockerfile
