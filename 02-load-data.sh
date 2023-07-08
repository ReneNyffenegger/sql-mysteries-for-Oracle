if [ $# -lt 2 ]; then
   echo run.sh  admin/pw  connect-id
   exit 1
fi

admin=$1
connect_identifier=$2

cd load-data

if ! sqlplus -silent -logon $admin@$connect_identifier @create-schema.sql ; then
   echo creating schema caused an error
   exit 1
fi

if ! sqlplus -silent -logon sql_mysteries/sql_mysteries@$connect_identifier @create-tables.sql ; then
   echo creating tables caused an error
   exit 1
fi



rm -f *.bad


if \
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=drivers_license.ctl        > /dev/null  ||
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=person.ctl                 > /dev/null  ||
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=income.ctl                 > /dev/null  ||
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=crime_scene_report.ctl     > /dev/null  ||
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=facebook_event_checkin.ctl > /dev/null  ||
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=interview.ctl              > /dev/null  ||
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=get_fit_now_member.ctl     > /dev/null  ||
   ! sqlldr  sql_mysteries/sql_mysteries@$connect_identifier control=get_fit_now_check_in.ctl   > /dev/null    ; then

     echo At least one sqlldr job returned an error status
     exit 1
fi

if ls *.bad 1>/dev/null 2>&1 ; then
   echo bad files were created
   exit 1
fi


if ! sqlplus -silent -logon sql_mysteries/sql_mysteries@$connect_identifier @post-process.sql $connect_identifier ; then
   echo problem with post processing
   exit 1
fi
