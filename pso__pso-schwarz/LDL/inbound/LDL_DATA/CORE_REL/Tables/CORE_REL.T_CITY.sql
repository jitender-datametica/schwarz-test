CREATE TABLE core_rel.T_CITY (
   city_sid                            NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the city.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   country_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
   iso_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code identifying the country according to ISO 3166.',
   country_name                        VARCHAR(100)    NOT NULL COMMENT 'The name by which the country is known,',
   city_name                           VARCHAR(100)    NOT NULL COMMENT 'The name by which the city is known,',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CITY PRIMARY KEY (city_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A city or village.';
