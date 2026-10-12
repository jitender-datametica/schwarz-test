CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_organisation_level_2 (
prod_org_lvl_name STRING(50) NOT NULL OPTIONS(description='The code for the product organisation level'),
prod_org_lvl_descr STRING(250) OPTIONS(description='A textual description for the product organisation level'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_org_lvl_name) NOT ENFORCED
)
OPTIONS(description='The Organisation level is a mapped field for every category in the GS1 article categorization system on level 4. Every Brickcode has a mapped Organisation level, which can be compared to the old Shop categorie 1, but now based first on the Brickcode structure. The Organisation level is a mapping to transfer the GS1 article categorization system to the structures of Lidl Digital.');