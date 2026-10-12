CREATE OR REPLACE TABLE kfl_production_dbp_etl.vis_plan_tag_wup_tmp (
mandant_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
gj INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
kjwo INTEGER NOT NULL,
mo_kj INTEGER NOT NULL,
akt_gj INTEGER NOT NULL,
akt_mo INTEGER NOT NULL,
akt_wo INTEGER NOT NULL,
akt_tag INTEGER NOT NULL,
wtag_id INTEGER NOT NULL,
dat DATE NOT NULL,
wrg_id STRING(3) NOT NULL,
plan_tag_fg INTEGER,
ums_netto_plan NUMERIC(18,2),
ums_netto_plan_extern NUMERIC(18,2)
);