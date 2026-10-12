/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_sales_per_hour_1
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:41:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_HGA_SALES_PER_HOUR_1 (
   hga_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
   sale_hour                           NUMBER(38, 0)   NOT NULL COMMENT 'The hour for a hot beverage product sale',
   sale_dt                             DATE            NOT NULL COMMENT 'The calendar_1 date of the hot beverage sales_1 ',
   hga_product_cat_id                  NUMBER(38, 0)   NOT NULL COMMENT 'The code for a hot beverage product',
   product_sale_cnt                    NUMBER(38, 0)   NOT NULL COMMENT 'The number of hot beverage product sales_1 per hour',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_HGA_SALES_PER_HOUR PRIMARY KEY (hga_sid, sale_hour, sale_dt, hga_product_cat_id) NOT ENFORCED
 )  COMMENT= 'Aggregated facts capturing Hot beverage product sales_1 per hour of hot beverage machines located in stores';
