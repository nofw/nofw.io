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

### What is Nofw?

Nofw (shamelessly following Symfony's example) is two things:

1. A set of component integration tools which lets you writting your own framework
2. A skeleton application presenting how those components can work together

You can copy and modify the skeleton, switch components, it's all up to you. In the end your framework should be tailored to you or your specific use case.


### Why no framework?

There is nothing wrong about frameworks except they nearly never fit your use case perfectly.

They try to be general solutions to all kinds of problems and because of that they hide complex magic under the hood and cover it with configuration. The problem is that even with configuration and extension points they still cannot think of Every Use Case Ever&trade; which leads to ugly hacks, lots of research, etc.

The other thing with magic is that it costs time....**response time**. Let's say you are writting a statistical REST API which needs to be blazing fast. This won't work if you have an event-driven layer in the background doing all kinds of magic which you might actually not need.

On the other hand the flexibility provided by frameworks can be useful if you want to quickly setup and build an application. Another advantage of frameworks is that they are (usually) well-documented which is almost never true for home made frameworks. When working in a team this documentation can be handy for newcomers, ease the learning curve, etc.

All in all, the flexibility comes at a price and you may not (always) want to pay it. Frameworks are not the evil, you just need to pick the right tools for the job.


### Docs? Are you nuts?

As said above, documentation is vital to understand the concepts. Although not being a framework, there are quire a few things to document here as well.

This documentation is a bit different though: it contains lots of instructions about **building** the framework, not about configuration and stuff. The instructions mostly build on the nofw skeleton, but they are general enough to be applied to any custom framework.
