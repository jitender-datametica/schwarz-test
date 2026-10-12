/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_ACCOUNTED_MODULE_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 3. Februar 2022 15:53:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_accounted_module_1 (
accounted_module_cd STRING(5) NOT NULL
OPTIONS(description='Unique identifier of the module from which a real-world document originates, and then is booked by accounting document'),
module_name_en STRING(100) OPTIONS(description='Name of the module in English'),
module_name_de STRING(100) OPTIONS(description='Name of the module in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (accounted_module_cd) NOT ENFORCED
)
OPTIONS(description='An "accounted module" is a module of the source system in which a real-world document is created (like logistics document) and then for this document we create accounting document(s).');