FROM php:7.1

RUN apt-get update -y \
  && apt-get install -y wget \

  # Install Xdebug
  && wget --no-check-certificate http://xdebug.org/files/xdebug-2.5.4.tgz -O /root/xdebug-2.5.4.tgz \
  && cd /root && tar -xvzf xdebug-2.5.4.tgz \
  && cd xdebug-2.5.4 \
  && phpize \
  && ./configure \
  && make test \
  && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303 \
  && echo ';zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so' \
      > /usr/local/etc/php/conf.d/100-xdebug.ini \

  # install Bats for running tests
  && curl -Ls https://github.com/sstephenson/bats/archive/master.tar.gz | tar -C /root -xzf - \
  && bash /root/bats-master/install.sh /usr/local \

  # init .bash_history
  && touch /root/.bash_history

ENV XDEBUG_INI=/usr/local/etc/php/conf.d/100-xdebug.ini \
  XDEBUG_EXT=/usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so

COPY .bashrc /root/
ADD tests.bats /code/
ADD xd_swi /code/
ADD entrypoint.sh /code/entrypoint.sh

ENTRYPOINT ["bash", "/code/entrypoint.sh"]
CMD ["bats", "/code/tests.bats"]
