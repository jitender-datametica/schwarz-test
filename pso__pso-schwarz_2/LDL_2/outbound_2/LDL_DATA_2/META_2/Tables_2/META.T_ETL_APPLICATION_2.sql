/* --------------------------------------------------------------------------------
   DDL for table: t_etl_application_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_etl_application_2 (
etl_appl_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the group of ETL jobs that form an application.'),
etl_appl_name STRING(100) NOT NULL OPTIONS(description='The name for the group of ETL jobs that form an application.'),
etl_appl_descr STRING(250)
OPTIONS(description='A textual description of the ETL application, detailing the purpose and structure of the application.'),
sys_name STRING(100) NOT NULL OPTIONS(description='The name of the system on which the application runs.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (etl_appl_sid) NOT ENFORCED
)
OPTIONS(description='ETL jobs which serve the same purpose, e.g. which load the same set of target tables, form an application');