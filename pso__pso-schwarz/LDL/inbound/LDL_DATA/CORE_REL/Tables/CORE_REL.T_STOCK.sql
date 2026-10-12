/* --------------------------------------------------------------------------------
   DDL for table: t_stock
   generated from Powerdesigner on Donnerstag, 6. März 2025 11:19:18
*/ --------------------------------------------------------------------------------
 
CREATE TABLE CORE_REL.T_STOCK CLUSTER BY (
     COUNTRY_ORG_CD,
     BUS_DT
)(
   prod_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   int_org_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
   bus_dt                              DATE            NOT NULL COMMENT 'The date for which the stock quanity is calculated.',
   stock_sales_unit_cnt                NUMBER(38, 0)   COMMENT 'The number of sales variants (that belong to the given product) which are on stock. E.g. if there are two boxes with 20 sales variants each, the stock count is 40. For weight-based products this attribute is empty.',
   stock_qty                           NUMBER(38, 5)   COMMENT 'The weight of the product which is on stock in the given store or warehouse, expressed in the indicated unit of measure. (This attribute is only filled for weight-based products.)',
   uom_cd                              VARCHAR(20)     COMMENT 'The code identifying the unit of measure for the stock quantity.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_STOCK PRIMARY KEY (prod_sid, int_org_sid, bus_dt) NOT ENFORCED
)  COMMENT= 'The stock entity describes, how many units of a certain product exist in a store or in a warehouse (i.e. a delivery company). Stock is shown either in kilograms (or any other unit of measure describing its weight) or as the number of sales variants of the respective product. So if there are two boxes with 20 sales item each, the stock count is 40. Stock is calculated from one day to another and shows the quantity that should exist at the end of the business day. An inventory may correct the stock.';