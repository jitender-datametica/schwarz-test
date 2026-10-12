CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_dispogruppen_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
dispogrupnr INTEGER NOT NULL,
dispogrupbez STRING(20),
datum DATETIME,
bediener STRING(8),
voraustage INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER
);