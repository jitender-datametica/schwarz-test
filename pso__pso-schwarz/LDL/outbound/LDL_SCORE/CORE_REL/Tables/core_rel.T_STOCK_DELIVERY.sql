CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_stock_delivery (
stock_delivery_nr STRING(50) NOT NULL OPTIONS(description='The unique identifier for the delivery entry'),
stock_delivery_pos_nr STRING(50) NOT NULL OPTIONS(description='The unique identifier for the delivery entry position'),
purchase_order_nr STRING(20) OPTIONS(description='Purchase order number of Wawi'),
site_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the site where goods are delivered.'),
bus_dt DATE NOT NULL OPTIONS(description='The date when delivery is registered'),
prod_variant_nan_nr STRING(50) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'),
pallet_factor_cnt BIGNUMERIC
OPTIONS(description='A numeric value representing how many cases of a product fit onto a single pallet.'),
case_cnt BIGNUMERIC OPTIONS(description='Count of delivered cases'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (stock_delivery_nr, stock_delivery_pos_nr) NOT ENFORCED
)
OPTIONS(description='The entity describes a delivery transaction that results in an increase of stock for a product at a particular location (RDC). This table serves as a detailed ledger of all goods received.             Source: Wawi');