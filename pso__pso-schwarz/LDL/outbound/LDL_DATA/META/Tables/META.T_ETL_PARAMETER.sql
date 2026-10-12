/* --------------------------------------------------------------------------------
   DDL for table: t_etl_parameter
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_etl_parameter (
pset_name STRING(100) NOT NULL OPTIONS(description='The name which uniquely identifies the parameter set.'),
param_name STRING(100) NOT NULL OPTIONS(description='The name which uniquely identifies the parameter.'),
param_descr STRING(250) OPTIONS(description='A textual description of the parameter, detailing its purpose.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (pset_name, param_name) NOT ENFORCED
)
OPTIONS(description='ETL jobs may define several parameters in order to make it easier to configure the job. When the job is executed, the parameter names get substituted with actual values.');