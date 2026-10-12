CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t118_statusdesc_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
status_2 INTEGER NOT NULL,
statusdesc STRING(50),
hq INTEGER,
wh INTEGER,
scn INTEGER DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL
);