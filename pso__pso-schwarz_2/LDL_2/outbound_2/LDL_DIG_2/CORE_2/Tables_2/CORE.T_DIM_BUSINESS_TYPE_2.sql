/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_BUSINESS_TYPE_2
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:40:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_business_type_2 (
business_type_cd STRING(50) NOT NULL OPTIONS(description='The code for business type of the customer '),
business_type_descr STRING(250) OPTIONS(description='The description for business type of the customer '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (business_type_cd) NOT ENFORCED
) OPTIONS(description='Dimension describes a what type of business is run by a customer ( Education, Law , Gastro)');