/* --------------------------------------------------------------------------------
   DDL for table: t_dim_store_real_estate_type
   generated from Powerdesigner on Mittwoch, 23. August 2023 09:57:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_store_real_estate_type (
store_real_estate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. '),
store_real_estate_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in group language, i.e. in German)'),
store_real_estate_type_descr_de STRING(250)
OPTIONS(description='A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in German)'),
store_real_estate_type_descr_en STRING(250)
OPTIONS(description='A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (store_real_estate_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. ');