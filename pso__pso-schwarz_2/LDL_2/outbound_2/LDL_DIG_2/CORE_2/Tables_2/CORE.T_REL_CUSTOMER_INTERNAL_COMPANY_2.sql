/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_CUSTOMER_INTERNAL_COMPANY_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 15. März 2022 12:57:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_customer_internal_company_2 (
internal_company_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company'),
cust_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
reconciliation_acct_nr STRING(20) NOT NULL
OPTIONS(description='The number of the reconciliation account_2 associated with this supplier_2 for this Lidl Company'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
PRIMARY KEY (internal_company_sid, cust_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The table contains relationship between Customer and Lidl Company, plus characteristics of this relationship - like reconciliation account_2 used by the company for this customer');