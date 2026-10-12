CREATE OR REPLACE TABLE DWH_WG_ERFASS_ARTIKEL_2 (
	ART_ID INTEGER NOT NULL COMMENT 'DWH-Artikelnummer',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	WG_ID INTEGER NOT NULL COMMENT 'ID der Warengruppe',
	ARTHIERTYP_ID INTEGER NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration'
);