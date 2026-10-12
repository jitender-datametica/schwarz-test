CREATE TABLE P_LEW_CORE.T_LIL_DATA_DELIVERY_CLASSIFICATION_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key CLIENT',
    SRC_REGION_CD VARCHAR(255) NOT NULL COMMENT 'Identifier of the country_1 region_1',
	SRC_PERIOD_NR NUMBER(38,0) NOT NULL COMMENT 'period identifier from the source',
	PERIOD_YEAR NUMBER(38,0) NOT NULL COMMENT 'year the period is related to',
	PERIOD_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Perioden-Typ-ID',
	DSC_NR NUMBER(38,0) NOT NULL COMMENT 'identifier of the data source company',
	LFL_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the like for like class (currently 0 or 1)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung'
)
COMMENT = 'table holds information about the data delivered by certain data providers forcertain periods and clients';
