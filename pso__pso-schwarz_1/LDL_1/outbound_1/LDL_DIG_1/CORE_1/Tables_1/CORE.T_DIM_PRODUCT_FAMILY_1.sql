/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_FAMILY_1
   GENERATED FROM POWERDESIGNER ON Montag, 13. März 2023 16:31:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_family_1 (
prod_family_cd STRING(20) NOT NULL
OPTIONS(description='The product Family Code represents the lower level of granularity of the Product Categories (sub_prod_group_cd).'),
prod_family_descr STRING(100) OPTIONS(description='Product family description'),
prod_subgroup_cd STRING(5)
OPTIONS(description='The product subgroup code describes the category a product is part of. Such as "baby clothes" or "Workshop - Machines" etc.'),
prod_group_cd STRING(20)
OPTIONS(description='Code of warengruppe - one of the LD classification for the products (DMM165-013, DMM165-014 , etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_family_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension containts information about product families and the product subgroups and groups these families belong to.');