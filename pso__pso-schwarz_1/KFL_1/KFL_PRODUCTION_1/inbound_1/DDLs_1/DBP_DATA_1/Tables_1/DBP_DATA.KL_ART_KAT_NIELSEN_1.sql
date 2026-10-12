CREATE TABLE DBP_DATA.KL_ART_KAT_NIELSEN_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	KL_ART_KAT_ID NUMBER(38,0) NOT NULL COMMENT 'ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_ART_KAT_BEZ VARCHAR(200) COLLATE 'en-ci' COMMENT 'Bezeichnung Kaufland Artikelkategorie für Nielsen-Daten',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Kaufland Artikelkategorien für Nielsen  (Hierarchie: Artikelkategorie (art_kat)- Warengruppe (wg)  - Oberwarengruppe (owg) - Unterwarengruppe (uwg))'
;