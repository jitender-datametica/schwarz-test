/* --------------------------------------------------------------------------------
   DDL for table: T_FREE_TRADE_AGREEMENT_CATEGORY_1
   generated from Powerdesigner on Mittwoch, 5. Juli 2023 14:45:55
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_FREE_TRADE_AGREEMENT_CATEGORY_1 (
   FREE_TRADE_AGREEMENT_CATEGORY_CD    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the category of a free trade agreement.',
   FREE_TRADE_AGREEMENT_CATEGORY_NAME  VARCHAR(100)    NOT NULL COMMENT 'The name of the category.',
   FREE_TRADE_AGREEMENT_CATEGORY_DESCR VARCHAR(250)    NOT NULL COMMENT 'A brief description of the category.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_FREE_TRADE_AGREEMENT_CATEGORY PRIMARY KEY (FREE_TRADE_AGREEMENT_CATEGORY_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the category of the free trade agreement, for example a bilateral agreement. - Source - Manual';
