CREATE OR REPLACE TABLE kfl_production_dbp_data.ginfo_flaeche_per (
mandant_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL,
ginfo_flaeche_id STRING(50) COLLATE 'und:ci' NOT NULL,
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci' NOT NULL,
dat_bis DATE NOT NULL,
ginfo_flaeche_netto NUMERIC(18,2) NOT NULL,
ginfo_flaeche_brutto NUMERIC(18,2),
ginfo_achse_wert NUMERIC(18,3),
ginfo_achse_typ_id STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);