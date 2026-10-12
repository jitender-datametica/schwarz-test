 CREATE TABLE P_LEW_CORE.T_LIL_RETAILER COMMENT = 'Einzelhaendler' CLUSTER BY (client_id)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
	RETAILER_SID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the Retailer (surrogate key)',
	SRC_RETAILER_CD VARCHAR(100) NOT NULL COMMENT 'Bezeichnung des Einzelhaendlers im Quellsystem',
	RETAILER_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'A code uniquely identifying the retailer type',
	RETAILER_NAME VARCHAR(100) COLLATE 'en-ci' NOT NULL COMMENT 'name of the retailer',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',
	UNIQUE (CLIENT_ID, RETAILER_SID),
	CONSTRAINT PK_T_LIL_RETAILER PRIMARY KEY (RETAILER_SID)
)
;