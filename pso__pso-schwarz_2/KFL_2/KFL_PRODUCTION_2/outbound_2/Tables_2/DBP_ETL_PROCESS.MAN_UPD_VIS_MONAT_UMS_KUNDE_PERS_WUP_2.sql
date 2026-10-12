CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.man_upd_vis_monat_ums_kunde_pers_wup_2 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
kjmo BIGNUMERIC(38,0),
ums_netto BIGNUMERIC(38,2),
pers_kosten BIGNUMERIC(38,2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
wrg_id STRING(3)
);