/* --------------------------------------------------------------------------------
   DDL for table: T_PACKAGING_MATERIAL_1
   generated from Powerdesigner on Freitag, 9. Mai 2025 15:14:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_packaging_material_1 (
packaging_material_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the packaging material as used in the source system.'),
packaging_material_name STRING(100) NOT NULL OPTIONS(description='The name of the packaging material.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (packaging_material_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the different types of packaging materials used in logistics and warehouse operations.');