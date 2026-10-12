CREATE OR REPLACE TABLE DWH_WG_ERFASS_ARTIKEL (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Artikelnummer',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration'
);