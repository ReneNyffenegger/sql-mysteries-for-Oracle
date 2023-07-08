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
infile '../original-data/income.csv' "str '\r\n'"
insert into table income
fields terminated by ',' optionally enclosed by '"'
(
   ssn,
   annual_income
)
