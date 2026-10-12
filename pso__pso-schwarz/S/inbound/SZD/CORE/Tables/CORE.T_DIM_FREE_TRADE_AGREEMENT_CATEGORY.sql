/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_FREE_TRADE_AGREEMENT_CATEGORY
   generated from Powerdesigner on Montag, 10. Juli 2023 09:08:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_FREE_TRADE_AGREEMENT_CATEGORY (
   FREE_TRADE_AGREEMENT_CATEGORY_CD    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the category of a free trade agreement.',
   FREE_TRADE_AGREEMENT_CATEGORY_NAME  VARCHAR(100)    NOT NULL COMMENT 'The name of the category.',
   FREE_TRADE_AGREEMENT_CATEGORY_DESCR VARCHAR(250)    NOT NULL COMMENT 'A brief description of the category.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_FREE_TRADE_AGREEMENT_CATEGORY PRIMARY KEY (FREE_TRADE_AGREEMENT_CATEGORY_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Defines the category of the free trade agreement, for example a bilateral agreement.  - Source - Manual';
