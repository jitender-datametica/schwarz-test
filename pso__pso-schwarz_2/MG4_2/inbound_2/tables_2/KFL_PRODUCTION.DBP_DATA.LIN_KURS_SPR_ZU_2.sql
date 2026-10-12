create or replace TABLE KFL_PRODUCTION.DBP_DATA.LIN_KURS_SPR_ZU_2 (
	LIN_KURS_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'ID des Kurses, z:Bsp. 186obs',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'PK - Mandant_2 im DWH',
	LIN_BERICHT VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Hinweis, in welchen Berichten der Kurs_2 relevant ist. Aus\n            report_of\n            Ausprägungen\n            - VIS\t\t(nur im VIS relevant)\n            - UWL \t\t(nur im LIN Bericht \"unternehmensweites Lernen\" relevant)\n            - BLANK\t(für beide Berichte relevant)',
	LIN_KURS_BEZ VARCHAR(255) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Kurses, z.Bsp. Warenkunde Obst',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_LIN_KURS_SPR_ZU primary key (LIN_KURS_ID, SPR_ID, MANDANT_ID, LIN_BERICHT)
)COMMENT='LIN - Sprachabhängige Bezeichnungen der LIN-Kurse'
;