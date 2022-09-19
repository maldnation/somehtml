FROM ubuntu:18.04
COPY index.html /var/www/html/
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
EXPOSE 80
