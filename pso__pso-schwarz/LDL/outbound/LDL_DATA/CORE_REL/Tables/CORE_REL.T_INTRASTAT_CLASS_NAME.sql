/* --------------------------------------------------------------------------------
   DDL for table: t_intrastat_class_name
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_intrastat_class_name (
intrastat_nr STRING(20) NOT NULL
OPTIONS(description='The Intrastat number which identifies a certain class of products.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
intrastat_name STRING(100) NOT NULL OPTIONS(description='The name for the Intrastat code.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (intrastat_nr, lang_cd) NOT ENFORCED
) OPTIONS(description='This table provides the translations of the names of an intrastat code in various languages.');