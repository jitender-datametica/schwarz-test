DROP TABLE IF EXISTS kfl_production_dbp_etl_process.nielsen_tlog_sales_1;
CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.nielsen_tlog_sales_1 (
receipt_id STRING(25),
mandant_id BIGNUMERIC(38,0),
store_id BIGNUMERIC(38,0),
shopping_datetime DATETIME,
bon_dat DATE,
product_id BIGNUMERIC(38,0),
purchase_ref_id STRING(255),
quantity BIGNUMERIC(30,3),
price_netto NUMERIC(20,8),
price_netto_euro BIGNUMERIC(38,12),
tax BIGNUMERIC(38,10),
tax_euro BIGNUMERIC(38,12),
umsatz_promo_netto NUMERIC(20,8),
umsatz_promo_netto_euro BIGNUMERIC(38,12),
currency_code STRING(3),
uom_quantity STRING(12),
promo_flag STRING(1),
vendor BIGNUMERIC(38,0),
upc NUMERIC(26,0),
channel_info STRING(20),
update_timestamp DATETIME
) CLUSTER BY mandant_id, store_id, bon_dat;