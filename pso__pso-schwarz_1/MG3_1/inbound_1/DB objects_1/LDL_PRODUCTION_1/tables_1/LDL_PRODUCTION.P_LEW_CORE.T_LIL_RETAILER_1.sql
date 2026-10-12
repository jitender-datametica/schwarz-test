create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_LIL_RETAILER_1 cluster by (client_id)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	RETAILER_SID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the Retailer (surrogate key)',
	SRC_RETAILER_CD VARCHAR(100) NOT NULL COMMENT 'Bezeichnung des Einzelhaendlers im Quellsystem',
	RETAILER_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'A code uniquely identifying the retailer type',
	RETAILER_NAME VARCHAR(100) NOT NULL COLLATE 'en-ci' COMMENT 'name of the retailer',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',
	unique (CLIENT_ID, RETAILER_SID),
	constraint PK_T_LIL_RETAILER primary key (RETAILER_SID)
)COMMENT='Einzelhaendler'
;