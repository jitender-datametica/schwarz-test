/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_sales_1
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:40:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_HGA_SALES_1 (
   hga_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
   sale_dt                             DATE            NOT NULL COMMENT 'The calendar_1 date of the hot beverage sales_1 ',
   sale_tm                             TIME(9)         NOT NULL COMMENT 'The time for the hot beverage sale',
   payment_type_id                     NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the payment type for a hot beverage',
   hga_product_cat_id                  NUMBER(38, 0)   NOT NULL COMMENT 'The code for a hot beverage product',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
   mug_type_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for a chosen mug type',
   sale_price                          NUMBER(38, 5)   NOT NULL COMMENT 'The price for a hot beverage product in national currency',
   sale_eur_price                      NUMBER(38, 5)   NOT NULL COMMENT 'The price for a hot beverage product in euro',
   lid_fg                              BOOLEAN         NOT NULL COMMENT 'An indicator showing if the customer choose a lid or not',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_HGA_SALES PRIMARY KEY (hga_sid, sale_dt, sale_tm) NOT ENFORCED
 )  COMMENT= 'Transactional facts capturing hot beverage product sales_1 of hot beverage machines located in stores';
