CREATE OR REPLACE TABLE DWH_WG_ERFASS_ARTIKEL_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Artikelnummer',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration'
);