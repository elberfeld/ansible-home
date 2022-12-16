
#!/bin/sh 

# Copy historical Data from server 
# Usage: sh copy-histdata.sh <someserver>

scp -r $1:{{ basedir }}/data/data/* {{ basedir }}/data/data/


