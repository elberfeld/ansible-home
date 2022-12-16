#!/bin/sh 
# Run Backtest for strategy 
# Usage: sh backtest-strategy.sh <strategy>

docker-compose run app backtesting --strategy $*

