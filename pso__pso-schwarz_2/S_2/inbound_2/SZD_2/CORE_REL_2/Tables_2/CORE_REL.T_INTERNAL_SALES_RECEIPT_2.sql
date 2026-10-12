/* --------------------------------------------------------------------------------
   DDL for table: T_INTERNAL_SALES_RECEIPT_2
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INTERNAL_SALES_RECEIPT_2 (
   SALES_RECEIPT_NR                    VARCHAR(250)    NOT NULL COMMENT 'The business receipt number of the internal sales_2 receipt.',
   RECIPIENT_PARTY_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party.',
   RECEIPT_DT                          DATE            NOT NULL COMMENT 'The date of the receipt.',
   DESIRED_DT                          DATE            NOT NULL COMMENT 'The desired delivery date of the client.',
   INVOICE_DT                          DATE            NOT NULL COMMENT 'The date of the invoice.',
   PERMITTED_PARTIAL_DELIVERY_CNT      NUMBER(38,0)    NOT NULL COMMENT 'Fact - additive - The count of permitted partial deliveries per position.',
   RECEIPT_CONDITION_NR                VARCHAR(250)    NOT NULL COMMENT 'The number of the receipt condition.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_INTERNAL_SALES_RECEIPT PRIMARY KEY (SALES_RECEIPT_NR) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Contains receipts for the internal sale of goods to stores from the LExIS system. - Source - Lexis';
