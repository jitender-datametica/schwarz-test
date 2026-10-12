CREATE TABLE DBP_DATA.MA_HIERARCHIE_ZU_PER (
	MA_ID NUMBER(38,0) NOT NULL COMMENT 'DWH ID des Mitarbeiters',
	MA_MUTTER_ID NUMBER(38,0) NOT NULL COMMENT 'DWH Mutter ID des Mitarbeiters',
	DAT_VON DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum, ab dem der Satz Gueltigkeit hat',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gueltigkeitsperiode. Format JJJJ-MM-TT',
	MANDANT_ID NUMBER(38,0) COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) COMMENT 'Marktnummer aus t001w.werks',
	MA_HIERARCHIE_EBENE_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Ma Hierarchieebene. Z.B. HL, VKL, GF',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Abbildung der Mitarbeiterhierarchien. Quelle ist zrs_vsdata'
;