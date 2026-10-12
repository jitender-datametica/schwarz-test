DROP TABLE IF EXISTS kfl_production_dbp_etl_process.as_food_mbst_2;
CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.as_food_mbst_2 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
kjwo BIGNUMERIC(38,0),
menge_lgbest_erp_frei_bme NUMERIC(18,3)
) CLUSTER BY kjwo;