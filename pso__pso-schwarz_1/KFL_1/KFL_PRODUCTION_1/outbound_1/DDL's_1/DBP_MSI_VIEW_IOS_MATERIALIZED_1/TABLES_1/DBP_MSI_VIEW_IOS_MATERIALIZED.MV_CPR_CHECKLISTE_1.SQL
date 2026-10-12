CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_cpr_checkliste_1 (
cpr_checkliste_id STRING(32) COLLATE 'und:ci',
projekt_phase_id STRING(32) COLLATE 'und:ci',
checkliste_nr STRING(30) COLLATE 'und:ci',
checklistenart_id STRING(20) COLLATE 'und:ci',
checkliste_gruppe_id STRING(40),
sap_user STRING(20) COLLATE 'und:ci',
nicht_relevant_fg INTEGER,
dat_aufloesung DATE,
cpr_suchfeld STRING(40) COLLATE 'und:ci',
teil_massn_fg INTEGER,
cpr_systemstatus1_id INTEGER,
cpr_systemstatus2_id INTEGER,
cpr_systemstatus3_id INTEGER,
mandant_id INTEGER
);