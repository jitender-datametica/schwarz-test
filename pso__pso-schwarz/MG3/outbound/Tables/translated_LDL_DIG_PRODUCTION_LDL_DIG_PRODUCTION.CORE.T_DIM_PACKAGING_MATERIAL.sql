CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_packaging_material (
pack_material_nr STRING(20) NOT NULL OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
pack_material_name STRING(100) OPTIONS(description='The name for  for the packaging material '),
pack_material_descr STRING(250) OPTIONS(description='The textual description for the packaging material '),
volume_uom_sid INTEGER OPTIONS(description='Unit of measurement for volume'),
volume_meas NUMERIC(29,5)
OPTIONS(description='Space that the material occupies per unit of volume. The volume refers to the unit specified in the volume unit field'),
weight_uom_sid INTEGER OPTIONS(description='Unit of measurement for weight'),
weight_meas NUMERIC(29,5) OPTIONS(description='Weight of the material'),
girth_uom_sid INTEGER OPTIONS(description='Unit of dimension for girth'),
girth_east_meas NUMERIC(29,5)
OPTIONS(description='Girth size of the material based on east european calculation standard'),
girth_west_meas NUMERIC(29,5)
OPTIONS(description='Girth size of the material based on west european calculation standard'),
length_uom_sid INTEGER OPTIONS(description='Unit of dimension for length'),
length_meas NUMERIC(29,5) OPTIONS(description='Length of the material'),
mean_length_meas NUMERIC(29,5) OPTIONS(description='Mean size of the material'),
shortest_length_meas NUMERIC(29,5) OPTIONS(description='Shortest size of the material'),
longest_length_meas NUMERIC(29,5) OPTIONS(description='Longest size of the material'),
width_uom_sid INTEGER OPTIONS(description='Unit of dimension for width'),
width_meas NUMERIC(29,5) OPTIONS(description='Width of the material'),
height_uom_sid INTEGER OPTIONS(description='Unit of dimension for height'),
height_meas NUMERIC(29,5) OPTIONS(description='Height of the material'),
main_supplier_sid INTEGER
OPTIONS(description='Account number of the main supplier identified for the packaging material '),
prod_add_nr_type_cd STRING(5)
OPTIONS(description='The type of of industry and lidl product numbers assigned (gtin, ean, producer numbers etc )'),
main_ean_nr STRING(20) OPTIONS(description='Lidl Internal international product number'),
palette_capacity_cnt INTEGER OPTIONS(description='Maximum quantity of items per palette.'),
package_capacity_cnt INTEGER OPTIONS(description='Maximum quantity of items per package.'),
container_capacity_cnt INTEGER OPTIONS(description='Maximum quantity of items per container.'),
prod_brick_cd STRING(40)
OPTIONS(description='The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. '),
prod_catalog_insert_dt DATE OPTIONS(description='Date when packaging material was inserted in product catalog'),
prod_catalog_update_dt DATE OPTIONS(description='Date of the last update of packaging material  in product catalog'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
material_pos_type_cd STRING(5)
OPTIONS(description='The code for the process type a product can be assigned to (e.g NORM, BANS).'),
PRIMARY KEY (pack_material_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This dimension defines the packaging material information (sourced from the product master data starting with 400..)');