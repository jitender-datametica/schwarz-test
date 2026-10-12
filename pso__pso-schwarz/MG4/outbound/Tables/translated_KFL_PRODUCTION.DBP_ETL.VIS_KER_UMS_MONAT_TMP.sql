CREATE OR REPLACE TABLE kfl_production_dbp_etl.vis_ker_ums_monat_tmp (
mandant_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
gj INTEGER NOT NULL,
akt_gj INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
akt_mo INTEGER NOT NULL,
mo_kj INTEGER NOT NULL,
ums_netto_ker NUMERIC(18,2),
ums_netto_ker_kvj NUMERIC(18,2),
ums_netto_ker_kvvj NUMERIC(18,2),
ums_netto_ker_plan NUMERIC(18,2),
ums_netto NUMERIC(18,2),
ums_netto_plan NUMERIC(18,2),
ums_netto_plan_extern NUMERIC(18,2)
);