set feedback off
whenever sqlerror exit 2

begin
--
-- Prevent ORA-01940: cannot drop a user that is currently connected
--     ( See https://renenyffenegger.ch/notes/development/databases/Oracle/errors/ORA-01940_cannot-drop-a-user-that-is-currently-connected )
--
   for r in (
      select
        'alter system kill session ''' || sid || ',' || serial# || ''' force'  stmt
      from
         gv$session
      where
         username ='SQL_MYSTERIES') loop

         dbms_output.put_line(r.stmt);
         execute immediate r.stmt;
    end loop;

    execute immediate 'drop user sql_mysteries cascade';
exception when others then
    if sqlcode != -1918 then -- ORA-01918: user … does not exist
       raise;
    end if;
end;
/

create user sql_mysteries identified by sql_mysteries
   default   tablespace users
   temporary tablespace temp
   quota unlimited on users;

grant
   create session,
   create table,
   create view
to
   sql_mysteries;

exit
