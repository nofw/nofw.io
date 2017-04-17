---
title: "Error monitoring"
date: "2017-04-17T14:44:56+02:00"

menu:
    docs:
        parent: "extras"
---

Error monitoring is a vital part of the software lifecycle. Without it, detecting (and quickly fixing) failures or having a realistic picture about the stability of your application is almost impossible.

Because of this high importance, there are quite a few, mostly SaaS solutions out there. While the skeleton cannot support them all out of the box, this page provides integration guides to a number of them.

If you don't find your desired service in the list, feel free to open an issue or send a PR.


### Logging or error handling

There are two common patterns for error monitoring:

- hook into a logger and pass all errors to it
- hook into some kind of global error handler

The first one is useful when an error is actually handled (the user of the application sees a "nice" *Sorry, this is not available at this time* message), but we want to make sure the error is reported.

The second one steps in when something goes terribly wrong and an unhandled error gets to the user.

These patterns are often combined and used together, but one has to make sure that an error is not reported twice.

Nofw comes with [Whoops](http://filp.github.io/whoops/) as it's [error handler](docs/components/error-handling/) which solves the second problem by registering a global error/exception handler and shows an error page to the user in case something goes wrong.

**TODO: improve this section**


### Integration

{{< collapsible >}}
    {{% collapsible-item title="Airbrake" %}}
[Airbrake](https://airbrake.io/) provides an official PHP client as well as a [Monolog](docs/components/logging/) handler. It seems to be actively maintained, so it can be a reliable choice.

Let's start by installing the client.

``` bash
$ composer require airbrake/phpbrake
```

Then register the notifier service in the [container](docs/components/dependency-injection/).

``` php
<?php

return [
    // ...
    \Airbrake\Notifier::class => \DI\object()->constructor(
        \DI\factory(function($host, $projectId, $projectKey, $env) {
            return [
                'host' => $host,
                'projectId' => $projectId,
                'projectKey' => $projectKey,
                'environment' => $env,
            ];
        })
        ->parameter('host', \DI\env('AIRBRAKE_HOST'))
        ->parameter('projectId', \DI\env('AIRBRAKE_PROJECT_ID'))
        ->parameter('projectKey', \DI\env('AIRBRAKE_PROJECT_KEY'))
        ->parameter('env', \DI\get('env'))
    ),
];
```

As you can see the above configuration expects the `AIRBRAKE_HOST`, `AIRBRAKE_PROJECT_ID` and `AIRBRAKE_PROJECT_KEY` environment variables to be configured. The last `env` parameter is the application environment which helps you distinguish different deployments (dev, test, prod) of the same application.

Optionally you can also register the Monolog handler as a service or just pass the notifier to your Monolog-factory.

``` php
<?php

return [
    // ...
    \Psr\Log\LoggerInterface::class => function (\Interop\Container\ContainerInterface $container) {
        $monolog = new \Monolog\Logger('nofw');

        // ...

        $monolog->pushHandler(new \Airbrake\MonologHandler($container->get(\Airbrake\Notifier::class)));

        // ...

        return $monolog;
    },
];
```

If your error handler is configured properly to send errors to Monolog you should start seeing errors in Airbrake.
    {{% /collapsible-item %}}
    {{% collapsible-item title="Errbit" %}}
[Errbit](https://errbit.com/) is an Airbrake compliant, self-hosted error catcher. Since it's API is identical to Airbrake's, the integration steps are almost the same as well.

The only difference between the two is that you have to add Errbit itself to your `docker-compose.yml` file.

``` yaml
version: "2.1"

services:
    app:
        # ...
        links:
            - errbit
        environment:
            AIRBRAKE_HOST: http://errbit:8080
            AIRBRAKE_PROJECT_ID: 1234
            AIRBRAKE_PROJECT_KEY: ABCD

    errbit:
        image: errbit/errbit
        links:
            - errbit_db
        environment:
            ERRBIT_USER_HAS_USERNAME: "true"
            PORT: 8080
            RACK_ENV: production
            MONGO_URL: mongodb://errbit_db:27017/errbit

    errbit_db:
        image: mongo:3.2
        volumes:
            - ./var/docker/mongo:/data/db
```
    {{% /collapsible-item %}}
{{< /collapsible >}}
