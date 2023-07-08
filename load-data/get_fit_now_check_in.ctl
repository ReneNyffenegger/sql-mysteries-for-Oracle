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
infile '../original-data/get_fit_now_check_in.csv' "str '\r\n'"
insert into table get_fit_now_check_in
fields terminated by ',' optionally enclosed by '"'
(
   membership_id,
   check_in_date   date "yyyymmdd",
   check_in_time,
   check_out_time
)
