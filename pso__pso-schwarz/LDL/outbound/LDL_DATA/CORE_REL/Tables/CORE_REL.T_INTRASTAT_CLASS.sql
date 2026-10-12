/* --------------------------------------------------------------------------------
   DDL for table: t_intrastat_class
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_intrastat_class (
intrastat_nr STRING(20) NOT NULL
OPTIONS(description='The Intrastat number which identifies a certain class of products.'),
intrastat_name STRING(100) NOT NULL OPTIONS(description='The name for the Intrastat number.'),
parent_intrastat_nr STRING(20)
OPTIONS(description='Intrastat numbers form a hierarchy. This is the upper level element in the hierarchy.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (intrastat_nr) NOT ENFORCED
)
OPTIONS(description='This minor entity contains the product classification codes according to Intrastat. (EU regulation 638/2004)');