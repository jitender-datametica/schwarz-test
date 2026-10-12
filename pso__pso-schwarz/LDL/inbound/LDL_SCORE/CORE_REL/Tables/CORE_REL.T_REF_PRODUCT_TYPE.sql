--==============================================================
-- Table: t_ref_product_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_product_type
   generated from Powerdesigner on Montag, 26. August 2024 08:10:19
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_PRODUCT_TYPE (
   product_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'A code for the type of the product e.g. TRADE.',
   product_type_descr                  VARCHAR(100)    NOT NULL COMMENT 'A textual description for the product_type_cd written out in group language (German).',
   product_type_descr_de               VARCHAR(100)    COMMENT 'A textual description for the product_type_cd written out in German.',
   product_type_descr_en               VARCHAR(100)    COMMENT 'A textual description for the product_type_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_PRODUCT_TYPE PRIMARY KEY (product_type_cd) NOT ENFORCED 
)  COMMENT = 'Dscribes the purpose of the goods. In our case it is only defined by the product_type_cd = TRADE = Trading Goods (Handelsware).';
