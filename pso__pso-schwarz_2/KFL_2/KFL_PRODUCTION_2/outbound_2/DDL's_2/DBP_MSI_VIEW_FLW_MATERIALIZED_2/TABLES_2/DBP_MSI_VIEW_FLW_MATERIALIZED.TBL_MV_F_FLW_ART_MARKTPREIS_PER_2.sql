CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_art_marktpreis_per_2 (
mandant_id INTEGER,
in_art_id INTEGER,
werk_id INTEGER,
flw_version_id STRING(3) COLLATE 'und:ci',
menge NUMERIC(29,3),
nicht_relevant_fg INTEGER,
pjwo INTEGER,
pjwo_vw INTEGER,
default_wrg STRING(12) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci',
bruttopreis NUMERIC(29,4),
dat_aenderung DATE
);