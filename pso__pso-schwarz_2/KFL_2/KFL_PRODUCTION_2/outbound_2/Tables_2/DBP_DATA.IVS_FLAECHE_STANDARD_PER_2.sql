CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_flaeche_standard_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
flaeche_id STRING(20) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
std_branche_id STRING(3) COLLATE 'und:ci',
std_vertragart_id STRING(3) COLLATE 'und:ci',
std_miete_betrag NUMERIC(18,4),
std_miete_qm_betrag NUMERIC(18,4),
std_miete_prozent NUMERIC(18,4),
system_id BIGNUMERIC(38,0),
buchungskreis_id BIGNUMERIC(38,0),
flaeche_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);