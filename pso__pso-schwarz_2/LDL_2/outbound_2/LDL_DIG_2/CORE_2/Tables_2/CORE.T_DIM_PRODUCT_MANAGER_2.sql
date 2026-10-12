/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_MANAGER_2
   GENERATED FROM POWERDESIGNER ON Freitag, 12. Mai 2023 16:09:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_manager_2 (
prod_manager_cd STRING(100) NOT NULL
OPTIONS(description='A code indentifiyng the product manager. Util we have actual code value we will be using the name of the manager as a code'),
prod_manager_name STRING(100) OPTIONS(description='Full name (first name + family name) of the product manager'),
prod_manager_team STRING(100) OPTIONS(description='Name of the team to which the product manager belongs'),
prod_manager_team_lead STRING(100)
OPTIONS(description='Full name (first name + family name) of the person who is the leader of the product management team'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_manager_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension that contains Product Managers.  Product manager is responsible for ordering of products, placing them in promotions, etc..');