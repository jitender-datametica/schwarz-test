/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_GENDER_2
   GENERATED FROM POWERDESIGNER ON Montag, 4. Juli 2022 15:35:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_gender_2 (
cust_gender_cd STRING(20) NOT NULL OPTIONS(description='The code for a gender of a customer ( M - Male , F - Female)'),
cust_gender_descr STRING(250) OPTIONS(description='The textual description for the gender of a customer '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_gender_cd) NOT ENFORCED
) OPTIONS(description='This dimension describes a gender of a customer ( M - Male , F - Female)');