CREATE TABLE DBP_DATA.MA_HIERARCHIE_ZU_PER_1 (
	MA_ID INTEGER NOT NULL COMMENT 'DWH ID des Mitarbeiters',
	MA_MUTTER_ID INTEGER NOT NULL COMMENT 'DWH Mutter ID des Mitarbeiters',
	DAT_VON DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum, ab dem der Satz Gueltigkeit hat',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gueltigkeitsperiode. Format JJJJ-MM_1-TT',
	MANDANT_ID INTEGER COMMENT 'Mandant_1 im DWH',
	WUP_ID INTEGER COMMENT 'Marktnummer aus t001w.werks',
	MA_HIERARCHIE_EBENE_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Ma Hierarchieebene. Z.B. HL_1, VKL_1, GF_1',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Abbildung der Mitarbeiterhierarchien. Quelle ist zrs_vsdata'
;