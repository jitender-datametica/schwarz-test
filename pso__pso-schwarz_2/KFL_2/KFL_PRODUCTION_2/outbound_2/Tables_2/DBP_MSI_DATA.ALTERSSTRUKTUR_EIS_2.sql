CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.altersstruktur_eis_2 (
altersstruktur_tag_id BIGNUMERIC(38,0),
altersstruktur_woche_id BIGNUMERIC(38,0),
altersstruktur_monat_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);