create or replace TABLE KFL_PRODUCTION.DBP_DATA.L_LIN_KURS_2 (
	LIN_KURS_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'ID des Kurses, z:Bsp. 186obs',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'PK - Mandant_2 im DWH',
	SORTKZ NUMBER(38,0),
	LIN_KURSGRUPPE_ID VARCHAR(10) COLLATE 'en-ci' COMMENT 'ID der Kursgruppe aus coursegroup_id',
	LIN_BERICHT VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Hinweis, in welchen Berichten der Kurs_2 relevant ist. Aus\n            report_of\n            Ausprägungen\n            - VIS\t\t(nur im VIS relevant)\n            - UWL \t\t(nur im LIN Bericht \"unternehmensweites Lernen\" relevant)\n            - BLANK\t(für beide Berichte relevant)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_LIN_KURS primary key (LIN_KURS_ID, MANDANT_ID, LIN_BERICHT)
)COMMENT='LIN - Lookuptabelle der Kurse'
;