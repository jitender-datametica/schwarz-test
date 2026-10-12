/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER
   GENERATED FROM POWERDESIGNER ON Donnerstag, 16. Februar 2023 13:39:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer (
cust_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
cust_type_cd STRING(5)
OPTIONS(description='The code for the customer type to differentiate whether an online shop or travel customer '),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
cust_nr STRING(20) OPTIONS(description='A customer number from original system'),
cust_org_type_cd STRING(5) OPTIONS(description='The code for the customer organisation type (IND or ORG)'),
cust_salutation STRING(100) OPTIONS(description='The salutation of the customer'),
cust_first_name STRING(100) OPTIONS(description='The first name of the customer'),
cust_last_name STRING(100) OPTIONS(description='The last name of the customer'),
cust_birth_dt DATE OPTIONS(description='The birth date of the customer'),
cust_company_name STRING(100) OPTIONS(description='Company name of the customer'),
cust_billing_addr_sid BIGNUMERIC
OPTIONS(description='The reference from the address table for the latest billing address of the customer'),
phone_nr STRING(100) OPTIONS(description='The phone number of the customer'),
email STRING(100) OPTIONS(description='The email address of the customer'),
cust_lan_cd STRING(5) OPTIONS(description='Language chosen by the customer'),
cust_sso_id STRING(80) OPTIONS(description='SSO id of the customer'),
cust_blocked_reason_cd STRING(5)
OPTIONS(description='The code for the central order block via certain payment types for a customer'),
cust_creation_dt DATE OPTIONS(description='The creation date of the record of the customer in the database'),
cust_registration_dt DATE OPTIONS(description='The registration date of the customer in the platform'),
cust_acct_id STRING(100)
OPTIONS(description='The account identifier which is SHA256 hash value to identify the SAP customer number'),
is_cust_adv_blocked_fg BOOL
OPTIONS(description='The indicator to identify if a customer opted for advertisement mailings or not'),
email_pcu STRING(100) OPTIONS(description='Column added for comparison test purpose between PCU and SAP src'),
phone_nr_pcu STRING(100) OPTIONS(description='Column added for comparison test purpose between PCU and SAP src'),
cust_sso_id_pcu STRING(80) OPTIONS(description='Column added for comparison test purpose between PCU and SAP src'),
is_cust_blocked_pcu_fg BOOL OPTIONS(description='Column added for test purpose -PCU source'),
is_cust_deleted_pcu_fg BOOL OPTIONS(description='Column added for test purpose -PCU source'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (cust_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A person who buys products from Lidl webshops');