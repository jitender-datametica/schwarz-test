CREATE TABLE DBP_DATA.MA_KONTINGENT_ZU_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	MITARBEITER_ID VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige anonymisierte ID des Mitarbeiters',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahresmonat',
	KONTINGENT_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Abwesenheitskontingenttyp; Feld:KTART; Quelle: IT2006-KTART',
	DAT_VON DATE NOT NULL COMMENT 'Beginn Gueltigkeit Abwesenheit ; Feld: ZHR_KTARTBEGDA ; Quelle: IT2006-begda',
	DAT_BIS DATE NOT NULL COMMENT 'Ende Gueltigkeit Abwesenheit ; Feld: ZHR_KTARTENDDA ; Quelle: IT2006-endda',
	ANZ_KONTINGENT NUMBER(9,2) DEFAULT 0 COMMENT 'Anzahl Abwesenheitskontinggenttyp ; Feld: ZHR_KTARTANZHL ; Quelle: IT2006-anzhl',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='Abwesenheitskontingente aus fuenften optionalen IDOC Untersegment Z100IFDWHMDS6'
;