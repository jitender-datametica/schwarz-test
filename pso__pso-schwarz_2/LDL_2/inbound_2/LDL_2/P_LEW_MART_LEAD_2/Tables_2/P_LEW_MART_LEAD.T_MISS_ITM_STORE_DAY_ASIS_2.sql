create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.T_MISS_ITM_STORE_DAY_ASIS_2 cluster by (	client_id, dat_formdate	)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'MIS Client ID',
	LOC_SID_STORE NUMBER(38,0) NOT NULL COMMENT 'S-Key der Location_2, hier der Filiale',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'S-Key für Item_2 Id',
	DAT_FORMDATE DATE NOT NULL COMMENT 'Bezugsdatum',
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Technische Zeitstempel'
)COMMENT='Tabelle für Fehlartikel: Granularität = client/loc_sid_store/item_sid/dat_formdate'
;
