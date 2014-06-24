---
title       : Epidemiological Deterministic Models
subtitle    : Exponential Growth and SIR model
author      : Tomas Fontecilla
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## This presentation

1. Epidemiological Models
2. Use of shinyApp
3. Future progress

---

## Epidemiological Models

* Early estimation of the basic reproduction number R$_0$ as early as possible in the face of
an epidemic is crucial for public health decision making. 
* The reason for this is that knowledge of the reproduction number gives valuable information for the estimation of the transmission potential of the epidemic and for the comparison of possible epidemic management strategies. 
* In an epidemic, there is an initial stochastic phase followed by exponential growth continuing until the number of members of the population who are no longer susceptible to infection becomes a significant fraction of the population. 
* It may be possible to obtain real time data sufficient to estimate this initial exponential growth rate, and this leads to the task of using these data to estimate R$_0$.
* However, the estimate of R0 obtained depends on the specific model being used for
the epidemic. Here, I present the simplest model, the Suceptible-Infectious-Recovered (SIR) model.

---

## Use of shinyApp

* This application shows the use of two types of deterministic models
* For SIR model, it is necessary to know the transmission rate and the number of days a number remains infecting people before recovery, as well as the initial suceptible population, initial infectious people (it must be greater than 0), and initial recovered people.

---

## Future progress

This application only has one type of model incorporated. In the future I expect to add other types of models such as:
* SIS model: Suceptible - Infectious - Suceptible model, where the recovery time is too short. An examplary disease would be common cold.
* SEIR model: Suceptible - Exposed - Infectious - Recovered model, where there is a lapse of time where a person is infected but is not yet infectious, been a carrier of the disease. An example would be measles.
* vaccined interrupted models of the previous ones. As before, but with the usage of a vaccine, such as the case of Influenza Like illness (ILI) disease.
