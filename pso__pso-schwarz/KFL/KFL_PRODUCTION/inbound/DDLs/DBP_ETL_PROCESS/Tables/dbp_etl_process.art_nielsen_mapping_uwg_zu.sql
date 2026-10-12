CREATE OR REPLACE TABLE ART_NIELSEN_MAPPING_UWG_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ART_NIELSEN_TAG VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'eindeutige Artikel-ID aus Nielsen ',
	GTIN_ID NUMBER(18,0) NOT NULL COMMENT 'Global Trade Item Number (GTIN)',
	ART_NIELSEN_BEZ VARCHAR(500) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung aus Nielsen ',
	KL_ART_KAT_ID NUMBER(38,0) COMMENT 'ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_WG_ID NUMBER(38,0) COMMENT 'ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_OWG_ID NUMBER(38,0) COMMENT 'ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_UWG_ID NUMBER(38,0) COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration'
);