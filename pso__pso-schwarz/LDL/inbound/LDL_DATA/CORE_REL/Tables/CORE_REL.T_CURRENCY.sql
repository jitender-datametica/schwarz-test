CREATE TABLE core_rel.T_CURRENCY (
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   curr_name                           VARCHAR(100)    NOT NULL COMMENT 'The name of the currency.',
   used_in_stores_fg                   BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this currency is used in a country where the Schwarz Group operates any stores.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CURRENCY PRIMARY KEY (curr_cd, lang_cd) NOT ENFORCED
)  COMMENT= 'A system of money that is in use in a country.';