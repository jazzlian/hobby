--
-- cr_
-- create roles

#
initdb –D $PGDATA  \
      -–no-locale \
      --encoding=UTF-8 \
      --auth=scram-sha-256 --auth=peer --auth-host=scram-sha-256 --auth-local=scram-sha-256 \
      --data-checksums --pwprompt --username=postgres \
      --waldir=$WALDIR --wal-segsize=128 \

#  enterprisedb option      
# --redwood-like       
# --no-redwood-compat (std)

#
sed -i ‘s#/var/lib/edb/as12/data#/ pgdata/data#g’ /usr/lib/systemd/ system/edb-as-12.service
systemctl enable edb-as-12
systemctl start edb-as-12