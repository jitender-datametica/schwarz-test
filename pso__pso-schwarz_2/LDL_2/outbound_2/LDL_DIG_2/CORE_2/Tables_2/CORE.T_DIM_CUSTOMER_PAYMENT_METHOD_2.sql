/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_PAYMENT_METHOD_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 8. August 2023 09:48:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_payment_method_2 (
cust_paym_method_cd STRING(5) NOT NULL OPTIONS(description='The code for the payment methods '),
cust_paym_method_descr STRING(250) OPTIONS(description='A textual description for the payment methods'),
is_secure_fg BOOL OPTIONS(description='Indicates if the payment method is considered secure'),
cust_paym_method_short_name STRING(250)
OPTIONS(description='The short version of the payment methods in group language'),
cust_paym_method_name STRING(250) OPTIONS(description='The full version of the payment methods in group language.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_paym_method_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the payment methods available in a system');