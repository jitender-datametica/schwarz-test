--==============================================================
-- Table: t_ref_currency
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_currency
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_CURRENCY (
   curr_cd                     VARCHAR(3)       NOT NULL COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'',''GBP'',…',
   curr_name                   VARCHAR(100)     COMMENT 'The full name of the currency',
   curr_name_de                VARCHAR(100)     COMMENT 'English description of the currency EUR = Euro',
   curr_name_en                VARCHAR(100)     COMMENT 'German description of the currency EUR = Euro',
   dwh_created_tmsp            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_CURRENCY PRIMARY KEY (curr_cd) NOT ENFORCED 
)  COMMENT = 'The ISO code for Currency';

