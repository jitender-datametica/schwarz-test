CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_client_2 (
client_id INTEGER NOT NULL OPTIONS(description='Surrogate Key CLIENT'),
src_client_id INTEGER OPTIONS(description='WAWI-DWH CLIENT_ID'),
src_country_lidl_cd STRING(160)
OPTIONS(description='Codes der Lidl-Laender: Oesterreich=AT;Nord-Irland:NI; USA=US; Deutschland=DE'),
src_country_cbx_cd STRING(160) OPTIONS(description='Codes bekannt aus CBX: Deutschland=DE, OnlineShopDeutschland=OSDE'),
client_name STRING(800) NOT NULL OPTIONS(description='Name des Mandanten in Stiftungs-Sprache'),
country_sid INTEGER OPTIONS(description='Lidl-Land_2; FK auf COUNTRY_2'),
country_cd STRING(160) NOT NULL OPTIONS(description='Lidl-Land_2-Code'),
curr_sid INTEGER OPTIONS(description='Landeswaehrung; FK auf CURRENCY'),
curr_cd STRING(160) OPTIONS(description='Landeswaehrung - Code; manuelle Befuellung, da keine direkte Quelle vorhanden'),
client_online_fg INTEGER NOT NULL OPTIONS(description='Client is Online Shop;'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
td_insert TIMESTAMP,
td_update TIMESTAMP,
lob_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='line of business code LDL,KFL, distinguishes between Lidl and Kaufland related clients')
);