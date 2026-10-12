/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_SUBGROUP
   GENERATED FROM POWERDESIGNER ON Montag, 13. März 2023 16:31:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_subgroup (
prod_subgroup_cd STRING(5) NOT NULL
OPTIONS(description='The product subgroup code describes the category a product is part of. Such as "baby clothes" or "Workshop - Machines" etc.'),
prod_subgroup_descr STRING(100) OPTIONS(description='Product subgroup description'),
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
PRIMARY KEY (prod_subgroup_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension containts information about all different product subgroups (Unterwarengruppen). A product subgroup is a parent of product family and a child of product group');