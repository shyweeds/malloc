![stars](https://img.shields.io/github/stars/shyweeds/malloc?style=social)
![CI](https://github.com/shyweeds/malloc/actions/workflows/ci.yml/badge.svg)
# CS:APP Malloc Lab

## Handout Files for Students

**Copyright (c) 2002, R. Bryant and D. O'Hallaron. All rights reserved.**  
May not be used, modified, or copied without permission.

---

## Main Files

`mm.{c,h}`  
: Your solution malloc package. `mm.c` is the file you will be handing in, and is the only file you should modify.

`mdriver.c`  
: The malloc driver that tests your `mm.c` file.

`short{1,2}-bal.rep`  
: Two tiny trace files to help you get started.

`Makefile`  
: Builds the driver.

---

## Other Support Files for the Driver

`config.h`  
: Configures the malloc lab driver.

`fsecs.{c,h}`  
: Wrapper function for the different timer packages.

`clock.{c,h}`  
: Routines for accessing the Pentium and Alpha cycle counters.

`fcyc.{c,h}`  
: Timer functions based on cycle counters.

`ftimer.{c,h}`  
: Timer functions based on interval timers and `gettimeofday()`.

`memlib.{c,h}`  
: Models the heap and `sbrk` function.

---

## Building and Running the Driver

To build the driver, run:

```bash
make
```

To run the driver on a tiny test trace:

```bash
mdriver -V -f short1-bal.rep
```
The -V option prints helpful tracing and summary information.

To get a list of the driver flags:
```bash
mdriver -h
```
