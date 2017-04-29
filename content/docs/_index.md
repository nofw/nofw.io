---
title: "Docs"
description: "Nofw documentation"
subtitle: "Even a non-framework requires a documentation"
date: "2017-04-17T03:56:09+02:00"

menu:
    docs:
        name: "Home"
        weight: -200
    main:
        weight: -210
---

## What is Nofw?

At a very high level Nofw is a philosophy of not using a framework for application development. When it comes to actual code, Nofw is two things:

1. A set of component integration tools
2. A skeleton application built using well-known, high quality components

You can copy and modify the skeleton, replace the components with preferred ones, it's all up to you. In the end your application should be tailored to your taste or your specific use case.


## Why no framework?

Frameworks are great. They provide flexibility which makes building all kinds of applications fast and easy. They are (usually) well-documented so using a framework can be a good choice for teams or those who just started learning web development.

Unfortunately, (as everything in this world) frameworks have downsides too: they are never made for your use case. They try to provide solutions to all kinds of problems by hiding some complex magic under the hood and covering it with configuration and extension points, but thinking of Every Use Case Ever&trade; is simply impossible which leads to ugly hacks, lots of research, etc.

Another serious problem with frameworks is that magic costs time....**response time**. Let's say you are working on a statistical REST API which needs to be blazing fast. It's quite hard to achieve if you have an event-driven layer in the background doing all kinds of magic which you might actually not need.

All in all, the flexibility and simplicity provided by frameworks comes at a price which you may not (always) want to pay. Frameworks are not the evil, but sometimes they are just not the right tools for the job.


## Docs? Are you nuts?

Although Nofw is not a framework with lots of shiny features, there are quite a few things to document here as well.

This documentation is a bit different though: it contains lots of instructions and examples about adding features to the application, not about configuration and stuff. The instructions mostly build on the Nofw skeleton, but they are general enough to be applied to any custom setup.
