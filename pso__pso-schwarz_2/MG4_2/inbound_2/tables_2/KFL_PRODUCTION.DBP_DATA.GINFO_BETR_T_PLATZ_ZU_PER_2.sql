create or replace TABLE KFL_PRODUCTION.DBP_DATA.GINFO_BETR_T_PLATZ_ZU_PER_2 (
	GINFO_ID NUMBER(38,0) NOT NULL COMMENT 'Vom Ginfo-System verwaltete eindeutige ID des technischen Platzes. Die techn_platz_id ist nicht immer eindeutig. Vorläufig wird die ginfo_id nur in dieser Tabelle verwendet',
	BETREIBERART_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID einer Betreiberart. Wird im DWH generiert',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
	TECHN_PLATZ_ID VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'Der technische Platz ist eine_2 von Kaufland Facility Management verwaltete Einheit',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GINFO_BETR_T_PLATZ_ZU_PER primary key (GINFO_ID, DAT_VON)
)COMMENT='IOS - Zuordnungstabelle der Betreiberarten zu technischen Plätzen'
;