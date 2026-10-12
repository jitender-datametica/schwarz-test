CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_geku_gebiets_betreuer_1 (
gebiets_betreuer_uid INTEGER,
fv_fg INTEGER,
fv_gb_id STRING(60) COLLATE 'und:ci',
gbb_name STRING(60) COLLATE 'und:ci',
gbb_vorname STRING(60) COLLATE 'und:ci',
gbb_anrede STRING(60) COLLATE 'und:ci',
gbb_strasse STRING(60) COLLATE 'und:ci',
gbb_plz STRING(60) COLLATE 'und:ci',
gbb_ort STRING(60) COLLATE 'und:ci',
gbb_land_id STRING(2) COLLATE 'und:ci',
mandant_id INTEGER,
gbb_email STRING(250) COLLATE 'und:ci',
gbb_tel_mobil STRING(60) COLLATE 'und:ci',
gbb_telefon STRING(60) COLLATE 'und:ci',
gbb_fax STRING(60) COLLATE 'und:ci'
);