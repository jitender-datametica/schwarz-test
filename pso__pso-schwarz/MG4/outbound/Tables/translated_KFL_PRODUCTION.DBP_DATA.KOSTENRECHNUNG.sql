CREATE OR REPLACE TABLE kfl_production_dbp_data.kostenrechnung (
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL,
pc_id STRING(10) COLLATE 'und:ci' NOT NULL,
plan_fg INTEGER NOT NULL,
planvariante_id STRING(4) COLLATE 'und:ci' NOT NULL,
buchungsperiode_id INTEGER NOT NULL,
gj INTEGER NOT NULL,
buchungskreis_id_ker STRING(6) COLLATE 'und:ci' NOT NULL,
system_id INTEGER NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
kostenrechnung_betrag NUMERIC(18,2),
kj_ker_mo_id INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);