CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_invest_plan_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_plan_gesamt_kz BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
datzeit_upload DATETIME,
sperr_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);