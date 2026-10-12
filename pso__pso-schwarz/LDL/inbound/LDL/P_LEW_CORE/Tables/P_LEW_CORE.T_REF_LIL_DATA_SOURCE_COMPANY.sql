CREATE TABLE P_LEW_CORE.T_REF_LIL_DATA_SOURCE_COMPANY (
	DSC_NR NUMBER(38,0) NOT NULL COMMENT 'identifier of the data source company',
	DSC_NAME VARCHAR(100) COMMENT 'name of the data source company',
	DSC_TYPE_CD VARCHAR(100) COMMENT 'type of the data source company (INTERNAL,EXTERNAL)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung'
)
COMMENT = 'table contains the list of data source companies providing data for liam lift';
