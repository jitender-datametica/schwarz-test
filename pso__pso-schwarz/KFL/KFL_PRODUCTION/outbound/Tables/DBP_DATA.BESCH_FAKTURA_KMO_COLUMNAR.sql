CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_kmo_columnar (
mandant_id BIGNUMERIC(38,0) NOT NULL,
faktura_beleg_id INTEGER NOT NULL,
fakturaart_id STRING(4) COLLATE 'und:ci' NOT NULL,
dat_faktura_sap DATE NOT NULL,
fktyp STRING(1) COLLATE 'und:ci' NOT NULL,
kurrf BIGNUMERIC(38,5),
dat_erstellung DATE NOT NULL,
zeit_erstellung BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
beleg_kondition_id TIME NOT NULL,
mandant_id_empfaenger BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);