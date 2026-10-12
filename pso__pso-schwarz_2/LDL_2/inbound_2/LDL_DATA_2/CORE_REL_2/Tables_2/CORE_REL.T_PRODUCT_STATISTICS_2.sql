/* --------------------------------------------------------------------------------
   DDL for table: t_product_statistics_2
   generated from Powerdesigner on Montag, 26. Februar 2024 21:03:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_STATISTICS_2 CLUSTER BY (BUS_DT)(
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store, in which the end-of-day processing happens.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_2 organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country_2 is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object in which the store is located.',
   stat_dt                             DATE            NOT NULL COMMENT 'The date when the product statistics were collected. ',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date for which the product statistics are generated.',
   curr_stat_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.',
   sales_variant_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the sales_2 variant for which statistics are calculated.',
   sold_cnt                            NUMBER(38, 0)   COMMENT 'The number of sales_2 variants which were sold. (In case the sales_2 variant is sold by weight, this attribute is empty.)',
   returned_cnt                        NUMBER(38, 0)   COMMENT 'The number of sales_2 variants which have been returned. (In case the sales_2 variant is sold by weight, this attribute is empty.)',
   cancel_cnt                          NUMBER(38, 0)   COMMENT 'The number of sales_2 variants for which the line was cancelled. (In case the sales_2 variant is sold by weight, this attribute is empty.)',
   sold_qty                            NUMBER(38, 5)   COMMENT 'The quantity of the sales_2 variant which was sold - in case the sales_2 variant is sold by weight instead of pieces.',
   returned_qty                        NUMBER(38, 5)   COMMENT 'The quantity of the sales_2 variant which have been returned- in case the sales_2 variant is sold by weight instead of pieces.',
   cancel_qty                          NUMBER(38, 5)   COMMENT 'The quantity of the sales_2 variants for which the line was cancelled - in case the sales_2 variant is sold by weight instead of pieces.',
   uom_cd                              VARCHAR(20)     COMMENT 'The code identifying the unit_2 of measure.',
   turnover_gross_val                  NUMBER(38, 5)   COMMENT 'The gross turnover in the currency indicated by the currency code, for this store, sales_2 variant and day.',
   returned_gross_val                  NUMBER(38, 5)   COMMENT 'The gross value of the sales_2 variants which have been returned.',
   cancel_gross_val                    NUMBER(38, 5)   COMMENT 'The gross value of the sales_2 variants for which the line was cancelled.',
   curr_cd                             VARCHAR(3)      COMMENT 'The code identifying the currency, according to ISO 4217.',
   last_sale_tmsp                      TIMESTAMP_TZ(9) COMMENT 'The time when the last sales_2 was made of this sales_2 variants.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_STATISTICS PRIMARY KEY (store_sid, real_estate_sid, bus_dt, stat_dt, sales_variant_sid) NOT ENFORCED
)  COMMENT= 'The event of producing product level statistics, showing the quantiy sold and the revenue for each sales_2 variant and store on the given day.';
