/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_BILLING_DOCUMENT_LINE_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 15. Mai 2024 15:56:36
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_BILLING_DOCUMENT_LINE_1 (
   BILLING_DOC_SID                     NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the billing document. It is generated based on sap_client_id, sap_system_name and billing_doc_nr',
   BILLING_DOC_POS_NR                  NUMBER          NOT NULL COMMENT 'The particular position of the item_1 in the billing document.',
   BILLING_DOC_NR                      VARCHAR(20)     COMMENT 'The unique number assigned to the billing document.',
   CUST_ORDER_SID                      NUMBER          COMMENT 'The unique identifier (surrogate key) for customer order',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   CUST_ORDER_POS_NR                   NUMBER          COMMENT 'The particular position number of an item_1 in an order',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_BILLING_DOCUMENT_LINE PRIMARY KEY (BILLING_DOC_SID, BILLING_DOC_POS_NR) NOT ENFORCED 
)  COMMENT = 'An ETL table that contains details about a billing document. A billing document is a generic term and it could be any of the following types  - invoice, credit note, debit note etc. 
             
             Source Table - SAP VBAP (Sales_1 Document: Item_1 Data) and SAP VBRP (Billing Document: Item_1 Data)';
