CREATE TABLE core_rel.T_STOCK_DELIVERY_2 (
   stock_delivery_nr                   VARCHAR(50)     NOT NULL COMMENT 'The unique identifier for the delivery entry',
   stock_delivery_pos_nr               VARCHAR(50)     NOT NULL COMMENT 'The unique identifier for the delivery entry position',
   purchase_order_nr                   VARCHAR(20)     COMMENT 'Purchase order number of Wawi',
   site_sid                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the site where goods are delivered.',
   bus_dt                              DATE            NOT NULL COMMENT 'The date when delivery is registered',
   prod_variant_nan_nr                 VARCHAR(50)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a logistic variant of a product.',
   pallet_factor_cnt                   NUMBER          COMMENT 'A numeric value representing how many cases of a product fit onto a single pallet.',
   case_cnt                            NUMBER          COMMENT 'Count of delivered cases',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_STOCK_DELIVERY PRIMARY KEY (stock_delivery_nr, stock_delivery_pos_nr) NOT ENFORCED 
)  COMMENT = 'The entity describes a delivery transaction that results in an increase of stock for a product at a particular location_2 (RDC). This table serves as a detailed ledger of all goods received.
             Source: Wawi';
