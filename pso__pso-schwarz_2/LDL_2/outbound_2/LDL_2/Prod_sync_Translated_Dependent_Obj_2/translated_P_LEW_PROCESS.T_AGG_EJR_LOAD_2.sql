CREATE OR REPLACE TABLE ldl_p_lew_process.t_agg_ejr_load_2 (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid INTEGER NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_2'),
aspect_id INTEGER OPTIONS(description='BGES/VGES Zuordnung; FK auf T_WAWI_ORG_STORE_MERGE_ACT_2'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Geschäftsdatum'),
core NUMERIC(29,5) OPTIONS(description='Anzahl Bons im Core'),
solace NUMERIC(29,5) OPTIONS(description='Anzahl Bons über SOLACE'),
dayend_completion NUMERIC(29,5) OPTIONS(description='Anzahl Bons aus dem Kassenabschlussbericht'),
ladequote NUMERIC(29,5) OPTIONS(description='Ladequote Core Beladung'),
ladequote_solace NUMERIC(29,5) OPTIONS(description='Ladequote Datenlieferung über SOLACE'),
store_open_fg NUMERIC(29,5) OPTIONS(description='Flag für die Filialöffnung'),
scenario INTEGER OPTIONS(description='Szenario für die Datenlieferung')
);