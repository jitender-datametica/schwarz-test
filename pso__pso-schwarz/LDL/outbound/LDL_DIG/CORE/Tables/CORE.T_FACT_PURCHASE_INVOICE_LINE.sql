/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PURCHASE_INVOICE_LINE
   GENERATED FROM POWERDESIGNER ON Dienstag, 29. November 2022 10:24:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_purchase_invoice_line (
purch_invoice_nr STRING(20) NOT NULL OPTIONS(description='Invoice document number'),
purch_invoice_pos_nr BIGNUMERIC NOT NULL
OPTIONS(description=' Identifier of item/position/line within invoice. An invoice can have many lines. For each invoice line numbers start with 1'),
fiscal_year BIGNUMERIC NOT NULL
OPTIONS(description='A number that represents the fiscal year for which the invoice document is posted'),
acct_doc_type_cd STRING(5) OPTIONS(description='Unique identifier of the document type'),
purch_invoice_dt DATE OPTIONS(description='Invoice document date (when invoice was issued)'),
purch_invoice_post_dt DATE OPTIONS(description='Invoice posting date (when invoice was registered in Financial system)'),
supplier_order_nr STRING(20) OPTIONS(description='Supplier Order Number present in the Purchase Order'),
supplier_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for supplier'),
supplier_nr STRING(20) OPTIONS(description='Account number of supplier/vendor from the sorce system'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
internal_company_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the company'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
curr_cd STRING(5) OPTIONS(description='Currency code in which order has been payed'),
purch_amt_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount in document currency  represents the value which is allocated to the specific purchase invoice'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a certain product ordered in a purchasing document'),
tax_country_cd STRING(5)
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
tax_type_cd STRING(5) OPTIONS(description='The code identifying the tax type'),
ref_doc_nr STRING(20) OPTIONS(description='A reference number for linking a material document with a billing document'),
ref_doc_pos_nr STRING(20)
OPTIONS(description='A reference number for linking a material document position with a billing document position'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (purch_invoice_nr, purch_invoice_pos_nr, fiscal_year) NOT ENFORCED
)
OPTIONS(description='A table that contains one row per purchase invoice line - That is invoices issued by a supplier to a Lidl Purchasing company');