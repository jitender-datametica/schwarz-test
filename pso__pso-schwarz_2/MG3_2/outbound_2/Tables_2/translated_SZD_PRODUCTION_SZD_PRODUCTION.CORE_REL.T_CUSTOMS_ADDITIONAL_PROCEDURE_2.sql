CREATE OR REPLACE TABLE szd_production_core_rel.t_customs_additional_procedure_2 (
additional_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the additional procedure code.'),
additional_procedure_descr STRING(250) OPTIONS(description='A brief description of the additional procedure code.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (additional_procedure_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This code defines special behaviours with products, for example goods that are imported under diplomatic privilege (personal use). These code contains the last 3 digits of a customs procedure code - Source - Manual');