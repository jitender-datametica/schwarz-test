/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_BILLING_DOCUMENT_HEADER
   GENERATED FROM POWERDESIGNER ON Mittwoch, 15. Mai 2024 15:56:17
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_BILLING_DOCUMENT_HEADER (
   BILLING_DOC_SID                     NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the billing document. It is generated based on sap_client_id, sap_system_name and billing_doc_nr',
   BILLING_DOC_NR                      VARCHAR(20)     COMMENT 'The unique number assigned to the billing document.',
   BILLING_DOC_TYPE_CD                 VARCHAR(5)      COMMENT 'The code for the type of billing document. (e.g.  ZCCN = Return Credit Note, ZCDN = Debit Note etc.)',
   BILLING_DOC_CAT_CD                  VARCHAR(5)      COMMENT 'The code for the category of the billing document. (e.g. R = Invoice list, O = Final Billing Document etc.) ',
   SD_DOC_CAT_CD                       VARCHAR(5)      COMMENT 'The code for the category of SD (Sales and Distribution) document. (e.g. A = Inquiry, B = Quotation, C = Order etc.)',
   RETURN_PAYM_TO_CUST_DT              DATE            COMMENT 'The date when the payment is transferred to the customer in case of a returned item.',
   RETURN_PAYM_TO_CUST_TMSP            TIMESTAMP_LTZ(9) COMMENT 'The timestamp when the payment is transferred to the customer in case of a returned item.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_BILLING_DOCUMENT_HEADER PRIMARY KEY (BILLING_DOC_SID) NOT ENFORCED 
)  COMMENT = 'An ETL table that contains one row per billing document header. A billing document is a generic term and it could be any of the following types  - invoice, credit note, debit note etc.
             
             Source Table - SAP VBRK (Billing Document: Header Data).';
