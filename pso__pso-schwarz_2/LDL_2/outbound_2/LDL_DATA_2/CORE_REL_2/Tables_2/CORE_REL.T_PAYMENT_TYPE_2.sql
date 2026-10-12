/* --------------------------------------------------------------------------------
   DDL for table: t_payment_type_2
   generated from Powerdesigner on Mittwoch, 15. Mai 2024 12:01:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_payment_type_2 (
paym_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for the way of payment, i.e. cash, card, voucher, etc.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
paym_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way of payment, i.e. cash, card, voucher, etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (paym_type_id, lang_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the way of payment, i.e. cash, card, voucher, etc.');