
#!/bin/sh 
# Download Data from Exchange for hyperopt and backtest

docker-compose run app download-data -t 1m 5m 15m 30m 1h 4h 1d 1w 2w $*
