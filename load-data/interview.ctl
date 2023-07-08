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
infile '../original-data/interview.csv' "str '\r\n'"
insert into table interview
fields terminated by ',' optionally enclosed by '"'
(
   person_id,
   transcript
)
