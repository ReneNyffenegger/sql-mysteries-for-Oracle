options (
   direct =  true,
-- log    = 'sqlldr-out',  -- Directory specification not honored?
-- bad    = 'sqlldr-out',  -- Directory specification not honored?
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
characterset  al32utf8
infile '../original-data/get_fit_now_member.csv' "str '\r\n'"
insert into table get_fit_now_member
fields terminated by ',' optionally enclosed by '"'
(
   id,
   person_id,
   name,
   membership_start_date   date "yyyymmdd",
   membership_status
)
