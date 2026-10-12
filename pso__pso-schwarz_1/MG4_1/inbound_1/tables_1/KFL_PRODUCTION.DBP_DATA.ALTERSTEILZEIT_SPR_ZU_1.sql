create or replace TABLE KFL_PRODUCTION.DBP_DATA.ALTERSTEILZEIT_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'PK - Mandant_1 im DWH',
	ATZ_PHASE_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Phase im Blockmodell. Gibt an, in welcher Phase sich der MA befindet, z.Bsp. BF',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
	ATZ_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung der Altersteilzeit-Phase',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ALTERSTEILZEIT_SPR_ZU primary key (MANDANT_ID, ATZ_PHASE_ID, SPR_ID)
)COMMENT='SHR - Sprachabhängige Bezeichnung der Altersteilzeit-Phasen'
;