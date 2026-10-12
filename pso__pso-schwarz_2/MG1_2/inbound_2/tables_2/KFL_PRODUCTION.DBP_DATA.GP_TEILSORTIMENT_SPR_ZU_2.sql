create or replace TABLE KFL_PRODUCTION.DBP_DATA.GP_TEILSORTIMENT_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	GP_TEILSORTIMENT_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Teilsortiment aus SAP ltsnr',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Sprache ID',
	GP_TEILSORTIMENT_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Kurzbezeichnung aus ltsbz',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GP_TEILSORTIMENT_SPR_ZU primary key (MANDANT_ID, GP_ID, GP_TEILSORTIMENT_ID, EINKAUFSORGANISATION_ID, SPR_ID)
)COMMENT='AIS_KMO- Sprachabhängige Bezeichnungen der Teilsortimente pro Lieferant aus der Quelle SAP wyt1t_2'
;