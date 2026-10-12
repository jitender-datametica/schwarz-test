CREATE TABLE DBP_DATA.L_MA (
	MA_ID INTEGER NOT NULL COMMENT 'ID des Mitarbeiters. Wird im Beladeprozess als SK erzeugt aus den Feldern MANDT, IDNR, FUNCTION (Historisierung aufgrund CRDAT(Datum der Neuanlage des Datensatz)).',
	DAT_VON DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum, ab dem der Satz Gueltigkeit hat',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	SAP_MA_ID INTEGER NOT NULL COMMENT 'SAP Mitarbeiter ID',
	MA_FUNKTION_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Die Funktion des Mitarbeiters aus der Quelle zrsvsdata.function.',
	DAT_BIS DATE NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Ende der Gueltigkeitsperiode. Format JJJJ-MM-TT',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Mitarbeitertabelle - SAP RET - ZRS_VSDATA'
;