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
infile '../original-data/drivers_license.csv' "str '\r\n'"
insert into table drivers_license
fields terminated by ',' optionally enclosed by '"'
(
   id,
   age,
   height,
   eye_color,
   hair_color,
   gender,
   plate_number,
   car_make,
   car_model
)
