CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.nielsen_store_master_bkp20260402_2 (
mandant_id BIGNUMERIC(38,0),
store_id BIGNUMERIC(38,0),
store_name STRING(160) COLLATE 'und:ci',
store_status STRING(1),
store_geo_level1 STRING(160) COLLATE 'und:ci',
store_geo_level2 STRING(160) COLLATE 'und:ci',
store_geo_level3 STRING(40) COLLATE 'und:ci',
store_geo_level4 STRING(8) COLLATE 'und:ci',
store_geo_coordinates STRING(103)
);