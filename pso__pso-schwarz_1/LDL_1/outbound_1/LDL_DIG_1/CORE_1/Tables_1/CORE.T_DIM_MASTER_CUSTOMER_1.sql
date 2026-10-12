/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_MASTER_CUSTOMER_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 11:59:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_master_customer_1 (
master_cust_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the master customer'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
cust_salutation STRING(100) OPTIONS(description='The salutation of the customer'),
cust_birth_dt DATE OPTIONS(description='The birth date of the customer'),
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
)
OPTIONS(description='A dimension that holds master customer data. Master customer record consolidates data of several records from customer dimension, combining them based on definied criteria. Lidl Travel data is not consolidated with Lidl online shop data.');