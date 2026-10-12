create or replace TABLE KFL_PRODUCTION.DBP_DATA.CPR_SUCHFELD_SPR_ZU_2 (
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
	CPR_SUCHFELD_ID NUMBER(38,0) NOT NULL COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
	SUCHFELD_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'zusätzliche Bezeichnung',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CPR_SUCHFELD_SPR_ZU primary key (SPR_ID, CPR_SUCHFELD_ID)
)COMMENT='IOS - sprachabhängige Bezeichnungen für das C-Projects Suchfeld'
;