--
-- Write multiple scripts to prevent PLS-00123: program too large.
--
set feedback off
set echo off
set trimspool on
set termout off
set lines 5000
set pages 0
set serveroutput on

spool sql-mysteries-1.sql

begin
   dbms_output.put_line('
set define off
declare
procedure a(id integer, age integer, height integer, eye_color varchar2, hair_color varchar2, gender varchar2, plate_number varchar2, car_make varchar2, car_model varchar2) is begin
   insert into drivers_license values(id, age, height, eye_color, hair_color, gender, plate_number, car_make, car_model);
end a;
procedure b(id integer, name varchar2, license_id integer, address_number integer, address_street_name varchar2, ssn varchar2) is begin
   insert into person values(id, name, license_id, address_number, address_street_name, ssn);
end b;
procedure c(ssn varchar2, annual_income integer) is begin
   insert into income values(ssn, annual_income);
end c;
begin
');
end;
/

select 'a(' || id || ',' || age || ',' || height || ',''' || eye_color || ''',''' || hair_color || ''',''' || gender || ''',''' || plate_number || ''',''' || car_make || ''',''' || car_model || ''');' from drivers_license;
select 'b(' || id || ',''' || name || ''',' || license_id || ',' || address_number || ','''|| address_street_name || ''',''' || ssn || ''');' from person;
select 'c(''' || ssn || ''',' || annual_income || ');' from income;


begin
dbms_output.put_line('
commit;
end;
/');
end;
/
spool off

spool sql-mysteries-2.sql

begin
   dbms_output.put_line('
declare
procedure d(date_ varchar2, type_ varchar2, description varchar2, city varchar2) is begin
   insert into crime_scene_report values(to_date(date_,''yyyymmdd''),type_, description, city);
end d;
procedure e(person_id integer, event_id integer, event_name varchar2, date_ varchar2) is begin
   insert into facebook_event_checkin values(person_id, event_id, event_name, to_date(date_,''yyyymmdd''));
end e;
procedure f(person_id integer, transcript varchar2) is begin
   insert into interview values(person_id, transcript);
end f;
procedure g(id varchar2, person_id integer, name varchar2, membership_start_date varchar2, membership_status varchar2) is begin
   insert into get_fit_now_member values(id, person_id, name, to_date(membership_start_date,''yyyymmdd''), membership_status);
end g;
procedure h(membership_id varchar2, check_in_date varchar2, check_in_time integer, check_out_time integer) is begin
   insert into get_fit_now_check_in values(membership_id, to_date(check_in_date,''yyyymmdd''), check_in_time, check_out_time);
end h;
begin
');
end;
/

select 'd(''' || to_char(date_,'yyyymmdd') || ''',''' || type_ || ''',''' || description || ''',''' || city || ''');' from crime_scene_report;
select 'e(' || person_id || ',' || event_id || ',''' || replace(event_name, '''', '''''') || ''',''' || to_char(date_, 'yyyymmdd') || ''');' from facebook_event_checkin;
select 'f(' || person_id || ',''' || replace(transcript, '''', '''''') || ''');' from interview;
select 'g(''' || id || ''',' || person_id || ',''' || name || ''',''' || to_char(membership_start_date,'yyyymmdd') || ''',''' || membership_status || ''');' from get_fit_now_member;
select 'h(''' || membership_id || ''',''' || to_char(check_in_date,'yyyymmdd') || ''',' || check_in_time || ',' || check_out_time || ');' from get_fit_now_check_in;

begin
dbms_output.put_line('
commit;
end;
/');
end;
/

spool off

exit
