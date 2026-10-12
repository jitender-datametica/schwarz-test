CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_vorschlagswert_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
ausg_menge_einh_id STRING(3),
paletten_faktor_einh_id STRING(3) COLLATE 'und:ci',
dat_bis DATE,
sortimentslistenart_id STRING(1) COLLATE 'und:ci',
zl_kolli_menge_einh_id STRING(3) COLLATE 'und:ci',
lage_faktor_einh_id STRING(3) COLLATE 'und:ci',
auspack_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);