CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_gs1_code (
gs1_cat_cd STRING(36) NOT NULL,
gs1_internal_cd STRING(20),
gs1_type_cd STRING(6),
gs1_group_cd STRING(20),
prod_org_lvl_name STRING(100)
OPTIONS(description='The Organisation level is a mapped field for every category in the GS1 article categorization system on level 4. Every Brickcode has a mapped Organisation level, which can be compared to the old Shop categorie 1, but now based first on the Brickcode structure. The Organisation level is a mapping to transfer the GS1 article categorization system to the structures of Lidl Digital.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (gs1_cat_cd) NOT ENFORCED
) OPTIONS(description='This ETL table to support brickcode .');