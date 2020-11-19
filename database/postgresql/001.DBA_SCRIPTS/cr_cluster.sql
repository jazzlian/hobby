#
initdb –D $PGDATA  \
      -–lc-collate=“C” \
      --lc-ctype=“C”  \
      --encoding=UTF8 \
      --auth=scram-sha-256 --auth-host=scram-sha-256 --auth-local=scram-sha-256 \
      --data-checksums --pwprompt --username=postgres \
      --waldir=$WALDIR --wal-segsize=128 \

#  enterprisedb option      
# --redwood-like       
# --no-redwood-compat (std)