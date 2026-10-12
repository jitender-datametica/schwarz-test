DROP TABLE IF EXISTS ldl_production_p_lew_process_mstr.t_lil_region_retailer;
CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_region_retailer (
client_id INTEGER NOT NULL,
region_sid INTEGER NOT NULL,
retailer_sid INTEGER,
rtl_id INTEGER NOT NULL,
region_rtl_desc_de STRING(100) COLLATE 'und:ci',
region_rtl_desc_en STRING(100) COLLATE 'und:ci',
rtl_lvl INTEGER NOT NULL,
active_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;