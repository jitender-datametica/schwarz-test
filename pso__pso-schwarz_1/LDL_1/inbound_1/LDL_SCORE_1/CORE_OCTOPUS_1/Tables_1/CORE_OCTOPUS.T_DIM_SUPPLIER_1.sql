CREATE TABLE CORE_OCTOPUS.T_DIM_SUPPLIER_1 (
   supplier_sid                        NUMBER          NOT NULL COMMENT 'Unique identifier for the supplier_1',
   supplier_nr                         VARCHAR(20)     COMMENT 'The number which identifies the supplier_1 in ',
   supplier_name                       VARCHAR(100)    COMMENT 'The name of the supplier_1',
   supplier_short_name                 VARCHAR(100)    COMMENT 'The short name of the supplier_1 (Cago: Kurzbezeichnung).',
   supplier_abbr_name                  VARCHAR(100)    COMMENT 'The abbreviated supplier_1 name',
   int_negot_fg                        BOOLEAN         COMMENT 'An indicator showing whether the company is internationally negotiated or country_1 specific.',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_SUPPLIER PRIMARY KEY (supplier_sid) NOT ENFORCED 
)  COMMENT = 'A company which delivers products to Lidl. The supplier_1 is not necessarily identical with the manufacturer. 
             It could also be a wholesaler who also sources the products from somewhere. Lidl dictates to the supplier_1 which items he needs';
