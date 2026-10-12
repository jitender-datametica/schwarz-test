create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_LIL_PERIOD_DESCR_2 cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the client',
	PERIOD_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key PERIOD',
	LANG_CD VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Sprache - Code',
	PERIOD_NAME VARCHAR(100) COLLATE 'en-ci' COMMENT 'Perioden-Beschreibung',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',
	constraint PK_T_LIL_PERIOD_DESCR primary key (PERIOD_SID, LANG_CD)
)COMMENT='$Revision: 0000 $ Uebersetzungstabelle fuer Periodenkennzeichnungen fur Projekt LIAM LIFT / CM\n             '
;
