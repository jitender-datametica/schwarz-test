/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CUSTOMS_ADDITIONAL_PROCEDURE
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:36:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_customs_additional_procedure (
additional_procedure_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of additional procedure.'),
additional_procedure_descr STRING(250) NOT NULL OPTIONS(description='The name of the type of the additional procedure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (additional_procedure_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Defines the additional procedure codes (the last three characters in a customs procedure code) and ther meaning. - Source - Manual');