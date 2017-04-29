---
title: "Advanced session"
date: "2017-04-17T14:45:10+02:00"

menu:
    docs:
        parent: "extras"
---

The basic [session middleware](docs/components/middleware-pipeline/) works fine for extremely simple applications, but in 2017 it hardly fulfills the requirements of an average application. It doesn't work well with scaling (requires sticky sessions) and it doesn't work at all with containerized applications (one cannot expect one specific container to continuously run, not to mention container restarts during deployments which immediately kills all the open sessions). Therefore the PHP built-in session management is not recommended to be used for such applications.

Luckily, PHP provides a [SessionHandlerInterface](http://php.net/manual/en/class.sessionhandlerinterface.php) which allows us to extend the built-in behaviour.


## Session handlers

Sessions usually contain temporary data (eg. current user ID), so it's no surprise that common cache solutions (like [Memcached](https://memcached.org/) and [Redis](https://redis.io/)) became popular targets as session storage. Fortunately (or not) there are quite a few cache abstractions out there for PHP:

- [Doctrine Cache](https://github.com/doctrine/cache)
- [PSR-6](http://www.php-fig.org/psr/psr-6/)
- [PSR-16](http://www.php-fig.org/psr/psr-16/)

The Session Handler interface is quite simple, so as implementing adapters for the abstractions above. Too make it even more simple, nofw provides that integration layer for you via the [nofw/session-handlers](https://github.com/nofw/session-handlers) package.

Nofw comes with Doctrine Cache preinstalled as (unfortunately) [PHP-DI's definition cache](http://php-di.org/doc/performances.html#cache) relies on it at the moment. Hopefully it will switch to one of the other standards above.

In the meantime, check [PHP Cache](http://php-cache.com/) out which is a great set of cache implementations compliant with both PSR-6 and PSR-16.


## Integration

Two popular cache backends (Memcached and Redis) are mentioned above, their integration will be covered in this part.

Both requires the installation of the aformentioned package, so go ahead and install it.

``` bash
$ composer require nofw/session-handlers
```

For both backends you have to tell PHP that you want to use a custom session handler, which you should do in your `bootstrap.php`.

``` php
<?php

//...

// Session setup
if ($container->has(\SessionHandlerInterface::class)) {
    session_set_save_handler($container->get(\SessionHandlerInterface::class), true);
}
```

We will get back to the container configuration later.


### Memcached

Memcached has some requirements which MUST be installed on the host (and are of course preinstalled in the [Docker base image](docs/environment/)).

``` bash
$ sudo apt-get install libmemcached-dev
$ sudo pecl install memcached
```

Once that's done, you can install Memcached itself. It's recommended to install it on a different server in production.

``` bash
$ sudo apt-get install memcached
```

Another option is running Memcached as a Docker container.

``` bash
$ docker run --rm -p 11211:11211 memcached:alpine
```

If you use the [Docker Compose setup](docs/environment/) bundled in nofw, add the following lines to your `docker-compose.yml` file.

``` yaml
version: "2.1"

services:
    app:
        # ...
        links:
            - memcached
        environment:
            MEMCACHED_HOST: memcached
            MEMCACHED_PORT: 11211

    memcached:
        image: "memcached:alpine"
```

Once the environment is configured, you need to add the following configuration to the [container](docs/components/dependency-injection/).

``` php
<?php

return [
    // ...
    \SessionHandlerInterface::class => \DI\object(\Nofw\Session\DoctrineCacheSessionHandler::class)->constructor(
        \DI\object(\Doctrine\Common\Cache\MemcachedCache::class)->method(
            'setMemcached',
            \DI\factory(function($host, $port) {
                $memcached = new \Memcached();

                $memcached->addServer($host, $port);

                return $memcached;
            })
            ->parameter('host', \DI\env('MEMCACHED_HOST'))
            ->parameter('port', \DI\env('MEMCACHED_PORT'))
        )
    ),
];
```

As you can see the above configuration expects the `MEMCACHED_HOST` and `MEMCACHED_PORT` environment variables to be configured (which is already done in the above Docker Compose configuration).



### Redis

TBD
