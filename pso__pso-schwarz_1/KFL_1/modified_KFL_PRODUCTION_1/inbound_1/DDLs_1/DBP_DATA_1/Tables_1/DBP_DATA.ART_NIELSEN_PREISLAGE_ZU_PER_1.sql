CREATE TABLE DBP_DATA.ART_NIELSEN_PREISLAGE_ZU_PER_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	ART_MATCHING_ID INTEGER NOT NULL COMMENT 'Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden',
	KJMO INTEGER NOT NULL COMMENT 'Monat_1 eines Kalenderjahres, Format JJJJMM',
	WRG_ID VARCHAR(12) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	KL_ART_KAT_ID INTEGER COMMENT 'ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_WG_ID INTEGER COMMENT 'ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_OWG_ID INTEGER COMMENT 'ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_UWG_ID INTEGER COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	HWG_ID INTEGER COMMENT 'ID der Hauptwarengruppe',
	OWG_ID INTEGER COMMENT 'ID der Oberwarengruppe',
	WG_ID INTEGER COMMENT 'ID der Warengruppe',
	WUG_ID INTEGER,
	DURCHSCHNITT_PREIS_KASSE NUMBER(29,4) COMMENT 'Durchschnittlicher VK_1 (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)',
	UMSATZ_BRUTTO NUMBER(29,4) COMMENT 'Bruttoumsatz aus Nielsen',
	UMSATZ_BRUTTO_AF NUMBER(29,4) COMMENT 'Bruttoumsatz aktionsfrei aus Nielsen',
	UMSATZ_BRUTTO_SA NUMBER(29,4) COMMENT 'Bruttoumsatz Sonderaktion aus Nielsen',
	MENGE NUMBER(29,3) COMMENT 'Menge aus Nielsen',
	MENGE_AF NUMBER(29,3) COMMENT 'Menge aktionsfrei aus Nielsen',
	MENGE_SA NUMBER(29,3) COMMENT 'Menge Sonderaktion aus Nielsen',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sortimentstool - Aggregation von Nielsen-Artikel_1 zum Vergleich mit Kaufland (Umsatz, Menge, Preis...) - Basisdaten Preislagen'
;