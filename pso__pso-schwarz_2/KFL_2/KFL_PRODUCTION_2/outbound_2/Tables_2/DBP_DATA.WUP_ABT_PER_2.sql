CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_abt_per_2 (
gjmo BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
abt_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
umsatz_netto_plan NUMERIC(18,2),
umsatz_netto_plan_wrg STRING(3) COLLATE 'und:ci',
umsatz_netto_plan_konz NUMERIC(18,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);