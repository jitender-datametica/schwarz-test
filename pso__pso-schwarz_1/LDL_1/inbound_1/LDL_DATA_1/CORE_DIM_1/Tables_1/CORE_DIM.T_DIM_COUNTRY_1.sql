/* --------------------------------------------------------------------------------
   DDL for table: t_dim_country_1
   generated from Powerdesigner on Mittwoch, 22. März 2023 07:19:51
*/ --------------------------------------------------------------------------------

CREATE TABLE core_dim.T_DIM_COUNTRY_1 (
   iso_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code identifying the country_1 according to ISO 3166.',
   country_name                        VARCHAR(100)    NOT NULL COMMENT 'The name by which the country_1 is known, in group language, i.e. German',
   country_name_de                     VARCHAR(100)    COMMENT 'The name by which the country_1 is known, in German.',
   country_name_en                     VARCHAR(100)    COMMENT 'The name by which the country_1 is known, in English.',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
   official_lang_cd                    VARCHAR(2)      NOT NULL COMMENT 'The code identifying the primary language which is used in this country.',
   stores_exist_fg                     BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the Schwarz Group operates any stores in this country.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_COUNTRY PRIMARY KEY (iso_country_cd) NOT ENFORCED
 )  COMMENT= 'A political country_1, i.e. a geopolitical region_1 with a sovereign governing. E.g. Germany, France, UK, ...';
