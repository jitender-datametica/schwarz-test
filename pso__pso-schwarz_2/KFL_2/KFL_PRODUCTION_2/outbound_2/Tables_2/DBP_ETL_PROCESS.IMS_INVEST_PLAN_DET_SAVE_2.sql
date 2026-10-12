CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ims_invest_plan_det_save_2 (
mandant_id BIGNUMERIC(38,0),
plan_version_id BIGNUMERIC(38,0),
hochrechnung_fg BIGNUMERIC(38,0),
gj_erstellung BIGNUMERIC(38,0),
excel_zeile BIGNUMERIC(38,0),
berichts_pos_invest_grp_id BIGNUMERIC(38,0),
gj BIGNUMERIC(38,0),
in_massnahme_typ_id STRING(3) COLLATE 'und:ci',
sparte_id BIGNUMERIC(38,0),
plan_betrag NUMERIC(18,4),
wrg_id STRING(3) COLLATE 'und:ci',
psp_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);