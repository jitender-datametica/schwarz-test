CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.lin_datenfreigabe_1 (
mandant_id INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
vertrieb_fg INTEGER NOT NULL,
user_id STRING(30) COLLATE 'und:ci',
zeitstempel DATETIME,
lin_freigabe_fg INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);