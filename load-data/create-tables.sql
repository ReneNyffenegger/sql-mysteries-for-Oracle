whenever sqlerror exit 2

set feedback off

create table drivers_license (
   id              integer,
   age             integer      not null,
   height          integer      not null,
   eye_color       varchar2( 5) not null check (eye_color  in ('brown', 'green', 'amber', 'blue', 'black''brown', 'green', 'amber', 'blue', 'black')),
   hair_color      varchar2( 6) not null check (hair_color in ('red', 'brown', 'green', 'grey', 'blue', 'white', 'black', 'blonde''red', 'brown', 'green', 'grey', 'blue', 'white', 'black', 'blonde')),
   gender          varchar2( 6) not null check (gender in ('male', 'female')),
   plate_number    varchar2( 6) not null,
   car_make        varchar2(15) not null,
   car_model       varchar2(25) not null,
   --
   constraint drivers_license_pk primary key(id)
)
pctfree 0;


create table person (
   id                  integer,
   name                varchar2(25) not null,
   license_id          integer      not null,
   address_number      integer      not null,
   address_street_name varchar2(30) not null,
   ssn                 varchar2( 9) not null,
   --
   constraint person_pk  primary key (id),
   constraint person_fk  foreign key (license_id) references drivers_license,
-- constraint person_fk2 foreign key (ssn       ) references income              -- No FK here, see https://github.com/NUKnightLab/sql-mysteries/issues/39
   constraint person_uq  unique      (ssn) 
)
pctfree 0;


create table income (
   ssn           not null /* varchar2(9) */,
   annual_income integer not null,
   --
-- constraint income_pk primary key(ssn)
   constraint income_fk foreign key(ssn) references person(ssn)
)
pctfree 0;


create table crime_scene_report (
   date_        date          not null,
   type_        varchar2( 10) not null,
   description  varchar2(300)     null,   -- 259
   city         varchar2( 20) not null    --  17
)
pctfree 0;


create table facebook_event_checkin (
    person_id      integer       not null,
    event_id       integer       not null,               -- TODO: Is this the primary key?
    event_name     varchar2(100)     null,
    date_          date          not null,
    --
    constraint facebook_event_checkin_fk foreign key (person_id) references person
)
pctfree 0;

create table interview (
   person_id                integer       not null,
   transcript               varchar2(250)     null,
   --
   constraint interview_fk foreign key (person_id) references person
)
pctfree 0;

create table get_fit_now_member (
   id                    varchar2( 5),
   person_id             integer      not null,
   name                  varchar2(20) not null,
   membership_start_date date,
   membership_status     varchar2( 7) not null check (membership_status in ('gold', 'silver', 'regular')),
   --
   constraint get_fit_now_member_pk primary key (id),
   constraint get_fit_now_member_fk foreign key (person_id) references person
)
pctfree 0;

create table get_fit_now_check_in (
   membership_id         ,
   check_in_date         date    not null,
   check_in_time         integer not null,
   check_out_time        integer not null,
   --
   constraint get_fit_now_check_in_fk foreign key (membership_id) references get_fit_now_member
)
pctfree 0;

exit
