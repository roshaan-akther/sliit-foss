#!/bin/bash

# prime number checker - the mathematical sentinel

# check if number is prime
is_prime() {
    local num=$1

# special cases first
    if [ "$num" -le 1 ]; then
        echo "$num is neither prime nor composite"
        return
    fi

# 2 is the only even prime
    if [ "$num" -eq 2 ]; then
        echo "$num is prime"
        return
    fi

# even numbers > 2 are composite
    if [ "$((num % 2))" -eq 0 ]; then
        echo "$num is composite"
        return
    fi

# check odd divisors up to sqrt(num)
    local i=3
    local sqrt_num=$(echo "sqrt($num)" | bc)

    while [ "$i" -le "$sqrt_num" ]; do
        if [ "$((num % i))" -eq 0 ]; then
            echo "$num is composite"
            return
        fi
        i=$((i + 2))  # skip even numbers
    done

    echo "$num is prime"
}

# main part
if [ $# -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

# make sure input is actually a number
if ! [[ "$1" =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$1' is not a valid integer"
    exit 1
fi

is_prime "$1"
