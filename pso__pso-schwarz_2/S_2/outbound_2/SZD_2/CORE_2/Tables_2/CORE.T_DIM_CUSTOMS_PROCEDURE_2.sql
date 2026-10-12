/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CUSTOMS_PROCEDURE_2
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:31:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_customs_procedure_2 (
customs_procedure_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the customs procedure.'),
requested_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the type of requested procedure.'),
requested_procedure_descr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - A brief description of the requested procedure code.'),
additional_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the type of additional procedure.'),
additional_procedure_descr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - A brief description of the additional procedure code.'),
customs_procedure_approve_status_cd STRING(50)
OPTIONS(description='The unique code of the type of customs procedure approval status.'),
customs_procedure_approve_status_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the type of the customs procedure approval status.'),
customs_procedure_approved_fg BOOL NOT NULL
OPTIONS(description='Denormalized Attribute - A flag indicating whether the customs procedure is approved.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_procedure_cd) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Contains all customs procedure codes used in a CDS item_2 report or in a Broker report - Source - CDS Item_2 Report, Broker Report, Manual');