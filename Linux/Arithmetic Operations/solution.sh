#!/bin/bash

read x
echo "$x" |bc -l | printf "%0.3f"  "$(cat)"
