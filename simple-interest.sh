#!/usr/bin/env bash
# This script calculates simple interest given principal,
# annual rate of interest and time period in years.

# Do not use this in production. Sample purpose only.

# Input:
# p, principal amount
# t, time period in years
# r, annual rate of interest

# Output:
# simple interest = p*t*r/100

read_number() {
    local prompt="$1"
    local value

    printf '%s\n' "$prompt"
    if ! IFS= read -r value; then
        printf 'Error: expected a non-negative number.\n' >&2
        return 1
    fi

    if [[ ! "$value" =~ ^([0-9]+([.][0-9]*)?|[.][0-9]+)$ ]]; then
        printf 'Error: expected a non-negative number.\n' >&2
        return 1
    fi

    REPLY="$value"
}

read_number 'Enter the principal:' || exit 1
principal=$REPLY
read_number 'Enter rate of interest per year:' || exit 1
rate=$REPLY
read_number 'Enter time period in years:' || exit 1
time=$REPLY

interest=$(awk -v principal="$principal" -v rate="$rate" -v time="$time" \
    'BEGIN { printf "%.2f", principal * rate * time / 100 + 0.000000001 }') || exit 1

printf 'The simple interest is: %s\n' "$interest"
