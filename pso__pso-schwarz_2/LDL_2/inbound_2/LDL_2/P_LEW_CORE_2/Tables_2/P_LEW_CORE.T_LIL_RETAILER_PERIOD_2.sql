create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_LIL_RETAILER_PERIOD_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH-Mandant_2 / DWH slice',
	RETAILER_SID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the Retailer (surrogate key)',
	PERIOD_SID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the Period (surrogate key)',
	RETAILER_SID_PARENT NUMBER(38,0) COMMENT 'unique identifier of the parent \""retailer\"", e.g. to which Financial Group a retailer belongs to',
	INTERFACE_NAME VARCHAR(100) NOT NULL COMMENT 'unique identifier of the interface, e.g. to which interface a retailer belongs to',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	constraint T_LIL_RETAILER_PERIOD_PK primary key (RETAILER_SID, PERIOD_SID, INTERFACE_NAME)
)COMMENT='Zuordnungen für Retailer für eine_2 Periode (z.B. zu Financial Groups)'
;
