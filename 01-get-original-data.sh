if ! command -v sqlite3 >/dev/null 2>&1; then
   echo Prerequisite sqlite3 does not exist
   exit 1
fi

if [ -d original-data ]; then
  echo directory original-data is already created and is presumed to be populated. Exting script
  exit 0
fi


if [ ! -d sql-mysteries ]; then
  echo Cloning github repo sql-mysteries
  git clone -q https://github.com/NUKnightLab/sql-mysteries
fi

mkdir original-data

echo Creating CSV files
for tab in $(sqlite3 sql-mysteries/sql-murder-mystery.db '.tables'); do

    echo "  ...$tab.csv"

    sqlite3 sql-mysteries/sql-murder-mystery.db <<%
.headers on
.mode csv
.output original-data/$tab.csv
select * from $tab;
%

done

echo Fixing referential integrity problems in original data
#
#  SSN 137882671 is not unique.
#  Update it for one one person:
#
sed -i '/Tushar Chandra/ s/137882671/137882670/' original-data/person.csv

#
#  There are persons whose license_id is not found in drivers_license:
#      select * from person where license_id not in (select id from drivers_license);
#
#      See also https://github.com/NUKnightLab/sql-mysteries/issues/39
#
#  The following command adds these to drivers_license.csv
#
sed -i '$a\
653712,54,65,green,green,female,SHTJIL,Scion,xB\
101191,43,56,amber,brown,female,2YDFHA,Nissan,Rogue\
173289,47,82,blue,grey,female,9I213D,Dodge,Neon\
108392,71,76,blue,green,female,F2P2NU,Kia,Sedona\
510019,55,67,blue,blue,female,7YUJKL,Chevrolet,Uplander' original-data/drivers_license.csv

echo done
