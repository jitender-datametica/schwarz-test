/* --------------------------------------------------------------------------------
   DDL for table: t_dim_store_real_estate_type_1
   generated from Powerdesigner on Mittwoch, 23. August 2023 09:57:33
*/ --------------------------------------------------------------------------------

CREATE TABLE core_dim.T_DIM_STORE_REAL_ESTATE_TYPE_1 (
   store_real_estate_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. ',
   store_real_estate_type_descr        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in group language, i.e. in German)',
   store_real_estate_type_descr_de     VARCHAR(250)    COMMENT 'A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in German)',
   store_real_estate_type_descr_en     VARCHAR(250)    COMMENT 'A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_STORE_REAL_ESTATE_TYPE PRIMARY KEY (store_real_estate_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. ';
