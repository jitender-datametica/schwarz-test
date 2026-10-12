CREATE OR REPLACE TABLE kfl_production_dbp_etl.unfall_tmp (
mandant_id INTEGER,
awart STRING(4) COLLATE 'und:ci',
z_pernr STRING(20),
monat INTEGER,
begda DATE,
folge_kz STRING(1) COLLATE 'und:ci'
);