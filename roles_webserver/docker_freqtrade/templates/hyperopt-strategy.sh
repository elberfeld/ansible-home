
#!/bin/sh 
# Run Hyperopt for strategy and srite Parameters file 
# Usage: sh hyperopt-strategy.sh <strategy>

docker-compose run app hyperopt -e 100 --spaces all --print-json --hyperopt-loss SharpeHyperOptLossDaily --strategy $*
