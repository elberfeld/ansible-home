
#!/bin/sh 
# Run Hyperopt for strategy and write Parameters file 

docker-compose run app hyperopt  --print-json -e 500 --strategy  Supertrend --hyperopt-loss ShortTradeDurHyperOptLoss --timeframe=1h --spaces buy sell roi stoploss trailing default 

