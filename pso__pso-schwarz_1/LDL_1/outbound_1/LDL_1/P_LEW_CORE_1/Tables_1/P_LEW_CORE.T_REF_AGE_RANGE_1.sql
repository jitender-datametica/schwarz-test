/* --------------------------------------------------------------------------------
   DDL for table: t_ref_age_range_1
   generated from Powerdesigner on Mittwoch, 18. Oktober 2023 10:19:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_age_range_1 (
age_range_cd STRING(100) NOT NULL OPTIONS(description='The code for the age range.'),
age_range_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the age range  (in default language).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (age_range_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the various codes for the age ranges.');