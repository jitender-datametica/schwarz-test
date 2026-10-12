/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_MASTER_CUSTOMER_SEGMENTATION_BASE_1
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:44:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_master_customer_segmentation_base_1 (
master_cust_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the master customer'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
cust_gender_cd STRING(20) OPTIONS(description='The code for a gender of a customer ( M - Male , F - Female)'),
cust_generation_cd STRING(50) OPTIONS(description='The code for a customer generation'),
zip_short_cd STRING(100)
OPTIONS(description='This field holds a shortened version of the billing address_1 postcode. The last character (either digit or letter) is removed to avoid identification of a customer.'),
city_name STRING(100) OPTIONS(description='The city name'),
country_name STRING(100) OPTIONS(description='A country_1 name'),
cust_birth_cy BIGNUMERIC OPTIONS(description='The birth year of the customer'),
is_business_fg BOOL OPTIONS(description='A flag indicating that customer is a business'),
business_type_cd STRING(50) OPTIONS(description='The code for business type of the customer '),
is_using_sso_fg BOOL OPTIONS(description='True if customer is using single sign on login process'),
is_cust_deleted_pcu_fg BOOL
OPTIONS(description='The indicator to identify if a customer is deleted (e.g. on customer demand or after certain period of inactivity)'),
is_cust_blocked_pcu_fg BOOL
OPTIONS(description='The indicator to identify if a customer is blocked (e.g. due to multiple unsuccessful logins)'),
is_cust_adv_blocked_fg BOOL
OPTIONS(description='The indicator to identify if a customer opted for advertisement mailings or not'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (master_cust_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A segmentation base for the master customer . Does not contain GDPR protected data.');