FROM php:7.1

# Install Xdebug
RUN apt-get update -y \
  && apt-get install -y wget \
  && wget --no-check-certificate http://xdebug.org/files/xdebug-2.5.4.tgz -O /root/xdebug-2.5.4.tgz \
  && cd /root && tar -xvzf xdebug-2.5.4.tgz \
  && cd xdebug-2.5.4 \
  && phpize \
  && ./configure \
  && make test \
  && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303 \
  && echo ';zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so' \
      > /usr/local/etc/php/conf.d/100-xdebug.ini

# install Bats for running tests
RUN curl -Ls https://github.com/sstephenson/bats/archive/master.tar.gz | tar -C /root -xzf - \
  && bash /root/bats-master/install.sh /usr/local

VOLUME /code
COPY .bashrc /root/
ADD ./ /code/

ENTRYPOINT bash /code/entrypoint.sh sleep infinity
