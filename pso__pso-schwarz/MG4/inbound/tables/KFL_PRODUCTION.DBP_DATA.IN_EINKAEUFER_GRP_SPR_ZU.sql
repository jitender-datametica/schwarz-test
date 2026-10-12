create or replace TABLE KFL_PRODUCTION.DBP_DATA.IN_EINKAEUFER_GRP_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
	EINKAEUFER_GRP_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Einkäufergruppe aus ekgr',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Sprache im DWH',
	EINKAEUFER_GRP_BEZ VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkäufergruppe aus eknam',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IN_EINKAEUFER_GRP_SPR_ZU primary key (MANDANT_ID, EINKAEUFER_GRP_ID, SPR_ID)
)COMMENT='BIS - Sprachabhängige Bezeichnung  der Einkäufergruppen im SAP Industrie-System. Quelltabelle ist t024'
;