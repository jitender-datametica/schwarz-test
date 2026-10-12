CREATE OR REPLACE TABLE dbp_msi_view_ios_materialized.tbl_mv_rpm_fin_planung (
dat_von DATE,
rpm_hierarchie_id STRING(32) COLLATE 'und:ci',
fin_kat_hierarchie_id STRING(32) COLLATE 'und:ci',
fin_kategorie_id STRING(20) COLLATE 'und:ci',
fin_kat_version_id STRING(10) COLLATE 'und:ci',
fin_kat_version_dat DATE,
fin_gruppe_hierarchie_id STRING(32) COLLATE 'und:ci',
fin_gruppe_id STRING(20) COLLATE 'und:ci',
rpm_plantyp_id INTEGER,
fin_gruppe_version_id STRING(10) COLLATE 'und:ci',
fin_gruppe_version_dat DATE,
dat_start DATE,
maxkp_fg INTEGER,
betrag NUMERIC(29,4),
projekt_nr STRING(32) COLLATE 'und:ci',
projekt_id STRING(32) COLLATE 'und:ci',
umrechnungskurs NUMERIC(29,5)
);