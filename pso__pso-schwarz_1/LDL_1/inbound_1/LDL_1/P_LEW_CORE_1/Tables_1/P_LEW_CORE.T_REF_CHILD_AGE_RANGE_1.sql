/* --------------------------------------------------------------------------------
   DDL for table: t_ref_child_age_range_1
   generated from Powerdesigner on Mittwoch, 14. Februar 2024 11:11:51
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_CHILD_AGE_RANGE_1 (
   child_age_range_cd                  VARCHAR(100)     NOT NULL COMMENT 'Code of the age range in which the child is categorized depending on the age.',
   child_age_range_name                VARCHAR(100)     NOT NULL COMMENT 'Name of the child age range.',
   child_age_range_descr               VARCHAR(250)     NOT NULL COMMENT 'Description of the child age range.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_CHILD_AGE_RANGE PRIMARY KEY (child_age_range_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the various codes for the different age ranges of children. Depending on the age of the child it will be categorized in one age range.';