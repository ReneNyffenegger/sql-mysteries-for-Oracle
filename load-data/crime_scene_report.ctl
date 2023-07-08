options (
   direct       =  true,
-- log          = 'sqlldr-out',  -- Directory specification not honored?
-- bad          = 'sqlldr-out',  -- Directory specification not honored?
   errors       =  0,
   skip         =  1,
   silent       = (header, feedback)
)
load data
characterset  al32utf8
infile '../original-data/crime_scene_report.csv' "str '\r\n'"
insert into table crime_scene_report
fields terminated by ',' optionally enclosed by '"'
(
   date_      date "yyyymmdd",
   type_,
   description char(300), -- char(300) apparently needed because of new lines in the field
   city
)
