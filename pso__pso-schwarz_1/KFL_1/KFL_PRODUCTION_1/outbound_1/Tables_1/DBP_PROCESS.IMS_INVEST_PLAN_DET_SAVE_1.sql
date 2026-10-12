CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.ims_invest_plan_det_save_1 (
mandant_id BIGNUMERIC(38,0),
plan_version_id BIGNUMERIC(38,0),
hochrechnung_fg BIGNUMERIC(38,0),
gj_erstellung BIGNUMERIC(38,0),
excel_zeile BIGNUMERIC(38,0),
berichts_pos_invest_grp_id BIGNUMERIC(38,0),
gj BIGNUMERIC(38,0),
in_massnahme_typ_id STRING(3),
sparte_id BIGNUMERIC(38,0),
plan_betrag NUMERIC(18,4),
wrg_id STRING(3),
psp_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);