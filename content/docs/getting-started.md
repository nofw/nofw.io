---
title: "Getting started"
date: "2017-04-17T13:40:13+02:00"
menu:
    docs:
        weight: -190
---

## Installation

The easiest way to create a new application is creating a project via [Composer](https://getcomposer.org/).

``` bash
$ composer create-project nofw/nofw:dev-master my-project
```

<div class="card-panel yellow lighten-4">
      <span class="brown-text text-darken-2"><strong>Note!</strong> Nofw is still under development, hence the <i>dev-master</i> constraint.</span>
</div>

If you don't have PHP installed on your computer (eg. you have everything in Docker) you can simply clone the project from [Github](https://github.com/nofw/nofw.git). In that case you need to take care of installing the dependencies.

``` bash
$ git clone https://github.com/nofw/nofw.git my-project
```

<div class="card-panel blue lighten-4">
      <span class="light-blue-text text-darken-4"><strong>Pro tip!</strong> You can run Composer from a <a href="https://hub.docker.com/_/composer/">Docker container</a>.</span>
</div>


## Starting the project

You have quite a few options for starting up the project. The recommended one is using [Docker](https://docker.com/), but it's optional.


### Docker


### Built-in PHP server

