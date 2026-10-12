CREATE OR REPLACE TABLE kfl_production_dbp_data.ts_scm_wup_cluster_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer'),
wup_cluster_id INTEGER NOT NULL OPTIONS(description='Marktcluster ID'),
nb_id INTEGER NOT NULL OPTIONS(description='Nebenbetrieb'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Marktcluster (Zuordnung) für KL_SCM');