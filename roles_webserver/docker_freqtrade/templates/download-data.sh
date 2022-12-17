
#!/bin/sh 
# Download Data from Exchange for hyperopt and backtest

docker-compose run app download-data -t "1m 5m 15m 1h 1d" $*
