create or replace TABLE KFL_PRODUCTION.DBP_DATA.L_GP_TEILSORTIMENT_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	GP_TEILSORTIMENT_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Teilsortiment aus SAP ltsnr',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
	ZAHLUNGSZIEL_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Zahlungsziel  aus lfm2.zterm',
	ZEK_ID VARCHAR(3) NOT NULL COMMENT 'Einkäufergruppe aus lfm2.ekgrp',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_GP_TEILSORTIMENT primary key (MANDANT_ID, GP_ID, GP_TEILSORTIMENT_ID, EINKAUFSORGANISATION_ID)
)COMMENT='AIS_KMO- Lookup-Tabelle der Teilsortimente pro Lieferant aus den Quellen SAP wyt1t_2 und lfm2_2'
;