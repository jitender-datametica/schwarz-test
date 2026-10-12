CREATE OR REPLACE TABLE kfl_production_dbp_etl.vis_personal_wup_tmp_1 (
mandant_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
gj INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
pers_std NUMERIC(18,2) NOT NULL,
pers_std_kvj NUMERIC(18,2) NOT NULL,
pers_std_plan NUMERIC(18,2) NOT NULL,
abwesenheit_tage NUMERIC(18,2) NOT NULL,
anz_tage NUMERIC(18,2) NOT NULL,
abwesenheit_tage_kvj NUMERIC(18,2) NOT NULL,
anz_tage_kvj NUMERIC(18,2) NOT NULL,
pers_austritte NUMERIC(18,2) NOT NULL,
pers_anz NUMERIC(18,2) NOT NULL,
pers_austritte_kvj NUMERIC(18,2) NOT NULL,
pers_anz_kvj NUMERIC(18,2) NOT NULL
);