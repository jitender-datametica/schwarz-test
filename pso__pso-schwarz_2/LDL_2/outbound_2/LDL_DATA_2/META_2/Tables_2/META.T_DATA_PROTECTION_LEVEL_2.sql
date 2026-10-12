/* --------------------------------------------------------------------------------
   DDL for table: t_data_protection_level_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_data_protection_level_2 (
data_prot_lvl_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how data objects need to be protected from unauthorized access. E.g. it labels personally identifiable information (PII) and data that needs to be protected for competitive reasons.'),
data_prot_lvl_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way, how data objects need to be protected from unauthorized access'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (data_prot_lvl_cd) NOT ENFORCED
)
OPTIONS(description='The data protection level defines how data objects need to be protected from unauthorized access. E.g. it labels personally identifiable information (PII) and data that needs to be protected for competitive reasons.');