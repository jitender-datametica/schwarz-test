/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_BILLING_DOCUMENT_HEADER_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 15. Mai 2024 15:56:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_billing_document_header_2 (
billing_doc_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the billing document. It is generated based on sap_client_id, sap_system_name and billing_doc_nr'),
billing_doc_nr STRING(20) OPTIONS(description='The unique number assigned to the billing document.'),
billing_doc_type_cd STRING(5)
OPTIONS(description='The code for the type of billing document. (e.g.  ZCCN = Return Credit Note, ZCDN = Debit Note etc.)'),
billing_doc_cat_cd STRING(5)
OPTIONS(description='The code for the category of the billing document. (e.g. R = Invoice list, O = Final Billing Document etc.) '),
sd_doc_cat_cd STRING(5)
OPTIONS(description='The code for the category of SD (Sales_2 and Distribution) document. (e.g. A = Inquiry, B = Quotation, C = Order etc.)'),
return_paym_to_cust_dt DATE
OPTIONS(description='The date when the payment is transferred to the customer in case of a returned item.'),
return_paym_to_cust_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the payment is transferred to the customer in case of a returned item.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (billing_doc_sid) NOT ENFORCED
)
OPTIONS(description='An ETL table that contains one row per billing document header. A billing document is a generic term and it could be any of the following types  - invoice, credit note, debit note etc.                          Source Table - SAP VBRK (Billing Document: Header Data).');