--==============================================================
-- Table: t_dim_supplier_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_supplier_2
   generated from Powerdesigner on Donnerstag, 8. August 2024 10:57:14
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SUPPLIER_2 (
   supplier_sid                        NUMBER          NOT NULL COMMENT 'Unique identifier for the supplier_2',
   supplier_nr                         VARCHAR(20)     COMMENT 'The number which identifies the supplier_2 in ',
   supplier_name                       VARCHAR(100)    COMMENT 'The name of the supplier_2',
   supplier_short_name                 VARCHAR(100)    COMMENT 'The short name of the supplier_2 (Cago: Kurzbezeichnung).',
   supplier_abbr_name                  VARCHAR(100)    COMMENT 'The abbreviated supplier_2 name',
   int_negot_fg                        BOOLEAN         COMMENT 'An indicator showing whether the company is internationally negotiated or country_2 specific.',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_SUPPLIER PRIMARY KEY (supplier_sid) NOT ENFORCED 
)  COMMENT = 'A company which delivers products to Lidl. The supplier_2 is not necessarily identical with the manufacturer. 
             It could also be a wholesaler who also sources the products from somewhere. Lidl dictates to the supplier_2 which items he needs';
