export	PGHOME=/opt/PostgreSQL/13
export	PGHOST=localhost
export	PGPORT=5432
export	PGUSER=postgres
export	PGDATA=/data/PG13
export	PGDATABASE=postgres
export  DATA_SOURCE_NAME="postgresql://postgres:audtlr2@localhost:5432/postgres?sslmode=disable"
#
export  PATH=$PGHOME/bin:$PATH
export  LD_LIBRARY_PATH=$PGHOME/lib:/lib64:/usr/lib64:.
#
export  EDITOR=vim
