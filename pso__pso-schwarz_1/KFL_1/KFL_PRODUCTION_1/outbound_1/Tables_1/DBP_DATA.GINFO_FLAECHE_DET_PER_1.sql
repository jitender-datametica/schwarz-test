CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ginfo_flaeche_det_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL,
ginfo_flaeche_id STRING(50) COLLATE 'und:ci' NOT NULL,
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci' NOT NULL,
kaufland_typ_id STRING(20) COLLATE 'und:ci' NOT NULL,
dat_bis DATE NOT NULL,
ginfo_flaeche_brutto NUMERIC(18,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);