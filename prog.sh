#!/bin/bash

# nrfjprog --recover
nrfjprog -f NRF52 --program main.hex --chiperase --verify
