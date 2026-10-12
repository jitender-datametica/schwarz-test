create or replace TABLE KFL_PRODUCTION.DBP_DATA.HR_MASSNAHME_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'PK - Mandant_1 im DWH',
	HR_MASSNAHME_GRUND_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Massnahmegrund',
	HR_MASSNAHME_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Massnahme, z.Bsp. A0',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
	HR_MASSNAHME_GRUND_BEZ VARCHAR(30) COLLATE 'en-ci' COMMENT 'Bezeichnung des Mitarbeiter-Massnahme-Grundes',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_HR_MASSNAHME_SPR_ZU primary key (MANDANT_ID, HR_MASSNAHME_GRUND_ID, HR_MASSNAHME_ID, SPR_ID)
)COMMENT='SHR - Sprachabhängige Bezeichnung der Personal-Massnahmen-Gründe'
;