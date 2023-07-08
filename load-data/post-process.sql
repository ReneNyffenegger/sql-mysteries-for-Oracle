--
--  sqlplus sql_mysteries/sql_mysteries@localhost:1521/freepdb1 @post-process.sql
--
set feedback off

update crime_scene_report     set description = trim(regexp_replace(description, chr(10) || ' *', ' '));
update facebook_event_checkin set event_name  = trim(regexp_replace(event_name , chr(10) || ' *', ' '));
update interview              set transcript  = trim(regexp_replace(transcript , chr(10) || ' *', ' '));
commit;

begin

   for cons in (
      select
         table_name,
         constraint_name
      from
         user_constraints
      where
         status = 'DISABLED'
    ) loop

       execute immediate 'alter table ' || cons.table_name || ' modify constraint ' || cons.constraint_name || ' enable validate';

    end loop;

end;
/

exit
