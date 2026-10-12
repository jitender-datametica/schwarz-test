CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_stock_2 (
site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
bus_dt DATE NOT NULL OPTIONS(description='The date for which the stock quanity is calculated.'),
prod_variant_nan_nr STRING(50) NOT NULL OPTIONS(description='National product number of product variant'),
stock_sales_unit_cnt BIGNUMERIC
OPTIONS(description='The number of sales_2 variants (that are contained in the given logistic variant) which are on stock. E.g. if there are two boxes with 20 sales_2 variants each, the stock count is 40. For weight-based products this attribute is empty.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (site_sid, bus_dt, prod_variant_nan_nr) NOT ENFORCED
)
OPTIONS(description='The stock entity describes, how many units of a certain product variant exist in a store or in a warehouse (i.e. a delivery company). Stock is always tracked for logistic variants - even in stores. Stock is shown either in kilograms (or any other unit_2 of measure describing weight) or as the number of sales_2 variants which are contained in the referenced logistic variant. So if there are two boxes with 20 sales_2 item_2 each, the stock count is 40. Stock is calculated from one day to another and shows the quantity that exists at the end of the business day. An inventory may correct the stock.             Source: Wawi');