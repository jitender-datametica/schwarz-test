CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.konditionen_det (
mandant_id BIGNUMERIC(38,0) NOT NULL,
konditionsart_id STRING(4) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
einkaufsorganisation_id BIGNUMERIC(38,0),
dat_bis DATE,
dat_von DATE,
kondition_betrag NUMERIC(18,4),
kondition_einh_id STRING(10) COLLATE 'und:ci',
kondition_preis_einh_id BIGNUMERIC(38,0),
kondition_menge_einh_id STRING(3) COLLATE 'und:ci',
loesch_kz STRING(1) COLLATE 'und:ci',
konditionssatz_id STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);