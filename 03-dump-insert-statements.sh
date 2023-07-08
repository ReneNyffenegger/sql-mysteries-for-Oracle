if [ $# -lt 1 ]; then
   echo run.sh  connect-id
   exit 1
fi

connect_identifier=$1

cd insert-statements/

if ! sqlplus -silent -logon sql_mysteries/sql_mysteries@$connect_identifier @dump.sql ; then
   echo could not create insert statements
   exit 1
fi


#
#  Use -j so that no path/directory structure
#  is stored in zip file
#
zip -j sql-mysteries.zip ../load-data/create-tables.sql  sql-mysteries-1.sql sql-mysteries-2.sql
