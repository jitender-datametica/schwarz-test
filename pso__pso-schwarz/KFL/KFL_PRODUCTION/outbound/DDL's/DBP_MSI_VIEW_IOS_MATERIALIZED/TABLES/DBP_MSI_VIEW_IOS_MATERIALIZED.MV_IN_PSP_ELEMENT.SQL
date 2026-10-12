CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_in_psp_element (
mandant_id INTEGER,
psp_id INTEGER,
psp_id_char STRING(30) COLLATE 'und:ci',
psp_bez STRING(40) COLLATE 'und:ci',
dat_abschluss DATE,
satus_psp DATE,
systemstatus_id STRING(5) COLLATE 'und:ci',
psp_end_nr INTEGER,
ims_projekt_typ_id STRING(1) COLLATE 'und:ci',
in_projekt_id INTEGER,
in_projekt_id_char STRING(30) COLLATE 'und:ci',
psp_projekt STRING(30) COLLATE 'und:ci',
projekt_nr STRING(30) COLLATE 'und:ci',
projekt_id STRING(32) COLLATE 'und:ci',
in_massnahme_typ_id STRING(3) COLLATE 'und:ci',
dat_massnahme_ende DATE
);