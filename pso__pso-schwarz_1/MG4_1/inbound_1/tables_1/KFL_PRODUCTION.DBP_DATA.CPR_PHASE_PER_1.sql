create or replace TABLE KFL_PRODUCTION.DBP_DATA.CPR_PHASE_PER_1 (
	PROJEKT_PHASE_ID VARCHAR(32) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Projektphase aus xlcphase',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
	PROJEKT_ID VARCHAR(32) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID des Projekts',
	CPR_EXT_ID VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'zusätzliche ID pro Projekt / Phase',
	DAT_FREIGABE DATE COMMENT 'Datum der Freigabe',
	EINZEL_MASSNAHME VARCHAR(30) COLLATE 'en-ci' COMMENT 'Einelmassnahme',
	TEIL_MASSNAHME_ID VARCHAR(30) COLLATE 'en-ci' COMMENT 'eindeutige ID der Teilmassnahme',
	TEIL_MASSN_KZ NUMBER(38,0) NOT NULL COMMENT 'Kennzeichen zur Teil-Massnahme. Enthält Werte von 1 bis 4',
	CPR_SYSTEMSTATUS1_ID NUMBER(38,0) NOT NULL COMMENT 'Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend',
	CPR_SYSTEMSTATUS2_ID NUMBER(38,0) NOT NULL COMMENT 'Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend',
	CPR_SYSTEMSTATUS3_ID NUMBER(38,0) NOT NULL COMMENT 'Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend',
	PHASENART_ID VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel der Phasenart, z.Bsp P7-Planung',
	CPR_SUCHFELD_ID NUMBER(38,0) COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
	CPR_PHASE_VERSION_ID VARCHAR(10) COLLATE 'en-ci' COMMENT 'Version (Kundenfeld) einer Phase aus zz_ppo_version. Inhalt z.Bsp. 1.1',
	CPR_PHASE_VERSION_DAT DATE COMMENT 'Datum_ab einer Version aus zz_ppo_datum_vom',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CPR_PHASE_PER primary key (PROJEKT_PHASE_ID, DAT_VON)
)COMMENT='IOS - Projektphase'
;