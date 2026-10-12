CREATE OR REPLACE TABLE ART_NIELSEN_MAPPING_UWG_ZU_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_NIELSEN_TAG VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'eindeutige Artikel_2-ID aus Nielsen ',
	GTIN_ID INTEGER NOT NULL COMMENT 'Global Trade Item_2 Number (GTIN)',
	ART_NIELSEN_BEZ VARCHAR(500) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung aus Nielsen ',
	KL_ART_KAT_ID INTEGER COMMENT 'ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_WG_ID INTEGER COMMENT 'ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_OWG_ID INTEGER COMMENT 'ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_UWG_ID INTEGER COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'technical fields for synchronisation framework. will be delted after last product migration'
);