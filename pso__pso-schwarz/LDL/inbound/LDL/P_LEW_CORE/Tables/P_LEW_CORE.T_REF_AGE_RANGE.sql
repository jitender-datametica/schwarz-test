/* --------------------------------------------------------------------------------
   DDL for table: t_ref_age_range
   generated from Powerdesigner on Mittwoch, 18. Oktober 2023 10:19:51
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_AGE_RANGE (
   age_range_cd                        VARCHAR(100)     NOT NULL COMMENT 'The code for the age range.',
   age_range_descr                     VARCHAR(250)     NOT NULL COMMENT 'A textual description for the age range  (in default language).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_AGE_RANGE PRIMARY KEY (age_range_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the various codes for the age ranges.';
