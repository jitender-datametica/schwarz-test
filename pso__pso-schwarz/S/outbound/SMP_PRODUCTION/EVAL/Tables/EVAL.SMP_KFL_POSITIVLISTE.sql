CREATE OR REPLACE TABLE smp_production_eval.smp_kfl_positivliste (
country STRING(12) COLLATE 'und:ci',
gtin STRING(16777216),
gtin_bez STRING(200) COLLATE 'und:ci',
retailer_id STRING(25),
start_date DATE,
end_date DATE
);