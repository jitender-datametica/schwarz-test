CREATE OR REPLACE TABLE kfl_production_dbp_data.wup_abt_per_1 (
gjmo INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
abt_id INTEGER NOT NULL,
arthiertyp_id INTEGER NOT NULL,
umsatz_netto_plan NUMERIC(18,2),
umsatz_netto_plan_wrg STRING(3) COLLATE 'und:ci',
umsatz_netto_plan_konz NUMERIC(18,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);