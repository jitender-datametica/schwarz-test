/* --------------------------------------------------------------------------------
   DDL for table: t_reporting_country_name_2
   generated from Powerdesigner on Mittwoch, 22. März 2023 07:15:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REPORTING_COUNTRY_NAME_2 (
   reporting_country_sid               NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the reporting country. (i.e. a country_2 definition which is different from a geographical country_2)',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   reporting_country_name              VARCHAR(100)    NOT NULL COMMENT 'The name of the reporting country_2 in the language indicated by the language code.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REPORTING_COUNTRY_NAME PRIMARY KEY (reporting_country_sid, lang_cd, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This table provides the translations of the name of the reporting country_2 in various languages.';
