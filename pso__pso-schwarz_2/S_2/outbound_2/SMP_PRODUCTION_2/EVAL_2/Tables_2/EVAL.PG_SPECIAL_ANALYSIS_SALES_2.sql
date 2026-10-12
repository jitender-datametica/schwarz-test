CREATE OR REPLACE TABLE smp_production_eval.pg_special_analysis_sales_2 (
shopper_id STRING(100) COLLATE 'und:ci',
receipt_dt DATE,
gtin STRING(100) COLLATE 'und:ci',
item_sid INTEGER,
campaign_id STRING(100),
campaign_group_id STRING(100),
quantity NUMERIC(29,4),
amount NUMERIC(29,2)
);