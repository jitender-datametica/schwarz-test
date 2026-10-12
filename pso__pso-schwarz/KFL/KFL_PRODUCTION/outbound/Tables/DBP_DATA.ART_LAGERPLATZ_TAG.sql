CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_lagerplatz_tag (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
lagerplatz_id STRING(10) COLLATE 'und:ci' NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
lagertyp_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mlgt_fg BIGNUMERIC(38,0) NOT NULL,
bestand_kz BIGNUMERIC(38,0),
lagerplatz_loesch_kz BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) DEFAULT 14 NOT NULL,
anzahl_quant BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY dat;