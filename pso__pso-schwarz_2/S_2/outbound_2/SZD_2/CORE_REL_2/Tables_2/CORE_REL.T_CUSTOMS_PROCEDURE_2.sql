/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_PROCEDURE_2
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:54:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_procedure_2 (
customs_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure code.'),
requested_procedure_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the requested_procedure code. These are the first 4 digits of the customs procedure code.'),
additional_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the additional procedure code.'),
approved_fg BOOL NOT NULL
OPTIONS(description='A flag indicating this customs procedure code is approved by the importer'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_procedure_cd) NOT ENFORCED
)
OPTIONS(description='Major Entity - The 7 digit customs procedure code contains of two components, the requested procedure code (the first 4 digits) and the additional procedure code (the last 3 digits). - Source - Manual');