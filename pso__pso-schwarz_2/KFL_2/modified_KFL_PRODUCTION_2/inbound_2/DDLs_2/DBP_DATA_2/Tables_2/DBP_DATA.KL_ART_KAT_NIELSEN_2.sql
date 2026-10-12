CREATE TABLE DBP_DATA.KL_ART_KAT_NIELSEN_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	KL_ART_KAT_ID INTEGER NOT NULL COMMENT 'ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_ART_KAT_BEZ VARCHAR(200) COLLATE 'en-ci' COMMENT 'Bezeichnung Kaufland Artikelkategorie für Nielsen-Daten',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Kaufland Artikelkategorien für Nielsen  (Hierarchie: Artikelkategorie (art_kat)- Warengruppe (wg)  - Oberwarengruppe (owg) - Unterwarengruppe (uwg))'
;