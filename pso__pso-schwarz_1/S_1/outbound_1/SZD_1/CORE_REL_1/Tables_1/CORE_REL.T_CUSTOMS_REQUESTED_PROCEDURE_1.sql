/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_REQUESTED_PROCEDURE_1
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:57:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_requested_procedure_1 (
requested_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the requested procedure code.'),
requested_procedure_descr STRING(250) OPTIONS(description='A brief description of the requested procedure code.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (requested_procedure_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This code determines whether and which conditions must apply to the imported goods, for example whether they may be released for free circulation. This code contains the first 4 digits of a customs procedure code. - Source - Manual');