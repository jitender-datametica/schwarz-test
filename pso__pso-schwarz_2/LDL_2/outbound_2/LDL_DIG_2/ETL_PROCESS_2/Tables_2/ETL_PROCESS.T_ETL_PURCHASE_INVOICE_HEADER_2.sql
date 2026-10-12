/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_PURCHASE_INVOICE_HEADER_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 29. November 2022 10:23:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_purchase_invoice_header_2 (
purch_invoice_nr STRING(20) NOT NULL OPTIONS(description='Invoice document number'),
fiscal_year BIGNUMERIC NOT NULL
OPTIONS(description='A number that represents the fiscal year for which the invoice document is posted'),
acct_doc_type_cd STRING(5) OPTIONS(description='Unique identifier of the document type'),
purch_invoice_dt DATE OPTIONS(description='Invoice document date (when invoice was issued)'),
purch_invoice_post_dt DATE OPTIONS(description='Invoice posting date (when invoice was registered in Financial system)'),
supplier_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for supplier_2'),
supplier_nr STRING(20) OPTIONS(description='Account_2 number of supplier_2/vendor from the sorce system'),
internal_company_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the company'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
tax_country_cd STRING(5)
OPTIONS(description='The unique code for a country_2 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
curr_cd STRING(5) OPTIONS(description='Currency code'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (purch_invoice_nr, fiscal_year) NOT ENFORCED
)
OPTIONS(description='An ETL-support table that contains one row per purchase invoice header ( That is invoices issued by a supplier_2 to a Lidl Purchasing company)');