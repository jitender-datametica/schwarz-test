/* --------------------------------------------------------------------------------
   DDL for table: T_INVOICE_STATUS_TYPE_2
   generated from Powerdesigner on Montag, 12. Februar 2024 08:43:25
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INVOICE_STATUS_TYPE_2 (
   INVOICE_STATUS_TYPE_CD              VARCHAR(50)     NOT NULL COMMENT 'The unique code of the invoice status_2 type.',
   INVOICE_STATUS_TYPE_NAME            VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the invoice status_2 type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_INVOICE_STATUS_TYPE PRIMARY KEY (INVOICE_STATUS_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the types of status_2 value an invoice can have. - Source - Manual';
