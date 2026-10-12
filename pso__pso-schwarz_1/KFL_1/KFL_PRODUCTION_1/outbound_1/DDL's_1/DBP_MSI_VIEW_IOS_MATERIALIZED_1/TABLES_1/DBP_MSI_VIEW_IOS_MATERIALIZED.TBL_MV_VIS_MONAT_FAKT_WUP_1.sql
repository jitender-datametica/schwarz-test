CREATE OR REPLACE TABLE dbp_msi_view_ios_materialized.tbl_mv_vis_monat_fakt_wup_1 (
mandant_id INTEGER,
nb_id INTEGER,
wup_id INTEGER,
rpm_hierarchie_id STRING(32) COLLATE 'und:ci',
vs_id INTEGER,
kjmo INTEGER,
expansionsbereinigung_dat DATE,
dat_eroeffnung DATE,
umsatz_netto_plan_euro NUMERIC(29,8),
umsatz_netto_vj_euro NUMERIC(29,8),
ums_netto NUMERIC(29,2),
ums_netto_kvj NUMERIC(29,2),
ums_netto_kvvj NUMERIC(29,2),
ums_netto_plan NUMERIC(29,2),
wrg_id STRING(3) COLLATE 'und:ci'
);