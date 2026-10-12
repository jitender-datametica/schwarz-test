/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_BILLING_DOCUMENT_LINE_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 15. Mai 2024 15:56:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_billing_document_line_1 (
billing_doc_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the billing document. It is generated based on sap_client_id, sap_system_name and billing_doc_nr'),
billing_doc_pos_nr BIGNUMERIC NOT NULL
OPTIONS(description='The particular position of the item_1 in the billing document.'),
billing_doc_nr STRING(20) OPTIONS(description='The unique number assigned to the billing document.'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_1 in an order'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (billing_doc_sid, billing_doc_pos_nr) NOT ENFORCED
)
OPTIONS(description='An ETL table that contains details about a billing document. A billing document is a generic term and it could be any of the following types  - invoice, credit note, debit note etc.                           Source Table - SAP VBAP (Sales_1 Document: Item_1 Data) and SAP VBRP (Billing Document: Item_1 Data)');