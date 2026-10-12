CREATE OR REPLACE TABLE kfl_production_dbp_data.art_vorschlagswert_per_2 (
mandant_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
ausg_menge_einh_id STRING(3),
paletten_faktor_einh_id STRING(3) COLLATE 'und:ci',
dat_bis DATE,
sortimentslistenart_id STRING(1) COLLATE 'und:ci',
zl_kolli_menge_einh_id STRING(3) COLLATE 'und:ci',
lage_faktor_einh_id STRING(3) COLLATE 'und:ci',
auspack_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);