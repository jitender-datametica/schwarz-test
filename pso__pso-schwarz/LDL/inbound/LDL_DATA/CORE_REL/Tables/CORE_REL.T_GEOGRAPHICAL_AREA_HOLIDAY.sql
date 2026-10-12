CREATE TABLE core_rel.T_GEOGRAPHICAL_AREA_HOLIDAY (
   cal_dt                              DATE            NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
   geo_area_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area.',
   geo_area_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminator for geographical areas.',
   holiday_cd                          VARCHAR(100)    NOT NULL COMMENT 'The code identifying the type of holiday. E.g. Christmas, Easter Sunday, ...',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   holiday_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of a holiday. E.g. public holiday or regional holiday.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_GEOGRAPHICAL_AREA_HOLIDAY PRIMARY KEY (cal_dt, holiday_cd, geo_area_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A relationship containing the holidays that exist for a certain geographical area. This may be on country level, for a territory or even down to city level. Depending on the location, a holiday may be of a different type. E.g. in Catholic regions of Germany August 15th is a public holiday, whereas in Protestant regions it is only a non-recognized holiday.';
