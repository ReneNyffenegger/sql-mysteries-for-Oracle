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
infile '../original-data/person.csv' "str '\r\n'"
insert into table person
fields terminated by ',' optionally enclosed by '"'
(
    id,
    name,
    license_id,
    address_number,
    address_street_name,
    ssn
)
