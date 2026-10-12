/* --------------------------------------------------------------------------------
   DDL for table: t_customer_identification_type_1
   generated from Powerdesigner on Mittwoch, 25. Januar 2023 20:59:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_customer_identification_type_1 (
cust_ident_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
cust_ident_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cust_ident_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the way how the customer identifies himself in the store, e.g. by his loyalty card.');