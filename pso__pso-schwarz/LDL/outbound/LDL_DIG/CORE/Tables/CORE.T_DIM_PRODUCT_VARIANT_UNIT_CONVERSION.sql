/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_VARIANT_UNIT_CONVERSION
   GENERATED FROM POWERDESIGNER ON Mittwoch, 13. November 2024 15:06:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_variant_unit_conversion (
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
unit_conversion_type_cd STRING(10) NOT NULL
OPTIONS(description='The code for the unit conversion type (e.g. PAL - palette, ST - piece, MBO - container, KOL - package, etc.)'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
unit_conversion_num_meas BIGNUMERIC(38,0) OPTIONS(description='The numerator for the given unit conversion type'),
unit_conversion_denom_meas BIGNUMERIC(38,0) OPTIONS(description='The denominator for the given unit conversion type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (prod_variant_sid, unit_conversion_type_cd) NOT ENFORCED
)
OPTIONS(description='This dimensional table contains conversion metrics at product variant level to pieces, boxes, pallets, etc. which are necessary for warehouse outbound and inbound reporting. E.g. a pallet can store 14 TVs so the corresponding product variant is going to have 14 as numerator and 1 as denominator for the unit conversion type "PAL".');