CREATE TABLE P_LEW_CORE.T_REF_LIL_LIKE_FOR_LIKE_DESCR_1 (
	LFL_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the like for like class (currently 0 or 1)',
	LFL_DESCR VARCHAR(250) COMMENT 'Description in German of Like for Like ID',
	LFL_DESCR_EN VARCHAR(250) COMMENT 'Description in English of LIke for Like ID',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung'
)
COMMENT = 'table contains the description of the like for like classes';
