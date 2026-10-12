/* --------------------------------------------------------------------------------
   DDL for table: t_ref_child_age_range_1
   generated from Powerdesigner on Mittwoch, 14. Februar 2024 11:11:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_child_age_range_1 (
child_age_range_cd STRING(100) NOT NULL
OPTIONS(description='Code of the age range in which the child is categorized depending on the age.'),
child_age_range_name STRING(100) NOT NULL OPTIONS(description='Name of the child age range.'),
child_age_range_descr STRING(250) NOT NULL OPTIONS(description='Description of the child age range.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (child_age_range_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the various codes for the different age ranges of children. Depending on the age of the child it will be categorized in one age range.');