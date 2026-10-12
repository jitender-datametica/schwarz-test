CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_rauchverlust_1 (
mandant_id INTEGER,
werk_id INTEGER,
dat_rauchvorgang DATE,
zeit_rauchvorgang TIME,
in_art_id INTEGER,
rauchwagen_id STRING(10) COLLATE 'und:ci',
flw_arbeitsplatz1_id STRING(8) COLLATE 'und:ci',
gewicht_netto_in NUMERIC(29,3),
gewicht_netto_out NUMERIC(29,3),
basismenge_einh_id STRING(3) COLLATE 'und:ci',
transport_einheit_id INTEGER,
flw_tenum_rauchprozess_kennzeichen STRING(3) COLLATE 'und:ci',
nettogew_diff_in_out NUMERIC(29,3)
);