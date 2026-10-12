CREATE TABLE core_rel.T_STOCK (
   site_sid                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   bus_dt                              DATE            NOT NULL COMMENT 'The date for which the stock quanity is calculated.',
   prod_variant_nan_nr                 VARCHAR(50)     NOT NULL COMMENT 'National product number of product variant',
   stock_sales_unit_cnt                NUMBER          COMMENT 'The number of sales variants (that are contained in the given logistic variant) which are on stock. E.g. if there are two boxes with 20 sales variants each, the stock count is 40. For weight-based products this attribute is empty.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_STOCK PRIMARY KEY (site_sid, bus_dt, prod_variant_nan_nr) NOT ENFORCED 
)  COMMENT = 'The stock entity describes, how many units of a certain product variant exist in a store or in a warehouse (i.e. a delivery company). Stock is always tracked for logistic variants - even in stores. Stock is shown either in kilograms (or any other unit of measure describing weight) or as the number of sales variants which are contained in the referenced logistic variant. So if there are two boxes with 20 sales item each, the stock count is 40. Stock is calculated from one day to another and shows the quantity that exists at the end of the business day. An inventory may correct the stock.
             Source: Wawi';
