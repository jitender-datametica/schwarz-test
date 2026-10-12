/*Aggregate Table for Storing Ladequote-Data*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_agg_ejr_load_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_1'),
aspect_id BIGNUMERIC(38,0) OPTIONS(description='BGES/VGES Zuordnung; FK auf T_WAWI_ORG_STORE_MERGE_ACT_1'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Geschäftsdatum'),
core NUMERIC(18,5) OPTIONS(description='Anzahl Bons im Core'),
solace NUMERIC(18,5) OPTIONS(description='Anzahl Bons über SOLACE'),
dayend_completion NUMERIC(18,5) OPTIONS(description='Anzahl Bons aus dem Kassenabschlussbericht'),
store_open_fg NUMERIC(18,5) OPTIONS(description='Flag für die Filialöffnung'),
ladequote NUMERIC(18,5) OPTIONS(description='Ladequote Core Beladung'),
ladequote_solace NUMERIC(18,5) OPTIONS(description='Ladequote Datenlieferung über SOLACE')
);