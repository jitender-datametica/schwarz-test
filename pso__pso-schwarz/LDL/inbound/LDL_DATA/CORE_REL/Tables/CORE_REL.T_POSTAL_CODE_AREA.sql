CREATE TABLE core_rel.T_POSTAL_CODE_AREA (
   postal_cd_area_sid                  NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the postal code area.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   country_sid                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
   iso_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code identifying the country according to ISO 3166.',
   country_name                        VARCHAR(100)    NOT NULL COMMENT 'The name by which the country is known,',
   zip                                 VARCHAR(15)     NOT NULL COMMENT 'A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany',
   postal_cd_area_name                 VARCHAR(100)    NOT NULL COMMENT 'The name by which the postal code area is known,',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT AK_ALTERNATE_KEY_T_POSTAL UNIQUE (iso_country_cd, zip)
       NOT ENFORCED,
   CONSTRAINT PK_T_POSTAL_CODE_AREA PRIMARY KEY (postal_cd_area_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'The geographical area which is identified by a zip code.';
