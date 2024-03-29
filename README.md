[![Build Status](https://github.com/nzidaric/fsr/workflows/CI/badge.svg?branch=master)](https://github.com/nzidaric/fsr/actions?query=workflow%3ACI+branch%3Amaster)
[![Code Coverage](https://codecov.io/github/nzidaric/fsr/coverage.svg?branch=master&token=)](https://codecov.io/gh/nzidaric/fsr)


# The FSR package for GAP

This is the README file for the GAP package "FSR" (Feedback Shift Register).

## Contact

Nusa zidaric, Mark Aagaard, Guang Gong 
{nzidaric, maagaard, ggong}@uwaterloo.ca

## Installation and usage

Extract to `gapinstallation/pkg/`.
That's it. Now start GAP and type
```
LoadPackage("FSR");
```
The "FSR" package banner should appear on the screen.

If you update a single `*.gd/*.gi` pair:
```
gap> RereadPackage("FSR", "lib/*.gd");
true
gap> RereadPackage("FSR", "lib/*.gi");
true
```
