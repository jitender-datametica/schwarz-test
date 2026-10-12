CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rohertrag_monat_wup (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
rohertrag NUMERIC(18,2) NOT NULL,
rohertrag_kum NUMERIC(18,2) NOT NULL,
rohertrag_kvj NUMERIC(18,2) NOT NULL,
rohertrag_kvj_kum NUMERIC(18,2) NOT NULL,
rohertrag_plan NUMERIC(18,2) NOT NULL,
rohertrag_plan_kum NUMERIC(18,2) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);