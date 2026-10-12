/* --------------------------------------------------------------------------------
   DDL for table: T_AGREEMENT_KEY_TYPE_2
   generated from Powerdesigner on Freitag, 17. November 2023 09:41:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_meta.t_agreement_key_type_2 (
agreement_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the agreement.'),
agreement_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the agreement.'),
agreement_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (agreement_key_type_cd) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Agreement - Contains the types that shares the key space for the subject area "Agreement".');