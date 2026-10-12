/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_SIZE_HANDLE_GROUP_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 27. Dezember 2023 14:25:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_size_handle_group_2 (
prod_size_handle_group_cd STRING(10) NOT NULL
OPTIONS(description='Product size classification defined by Controlling/PM. It divides the product size in types based on their dimensions (P_KT,P_GT,P_2MH, P_Sonst).            Necessary for evaluation of variable and fixed costs based on the size group.'),
prod_size_handle_group_descr STRING(250)
OPTIONS(description='A textual description for the product size classification in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_size_handle_group_cd) NOT ENFORCED
)
OPTIONS(description='Minor dimension for codes used for the DBR (Margin Contribution) Report. It divides the product size in types based on how they will be handled as packages (P_KT,P_GT,P_2MH ...  )');