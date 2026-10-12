CREATE TABLE DBP_DATA.ART_NIELSEN_PREISLAGE_ZU_PER (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ART_MATCHING_ID NUMBER(38,0) NOT NULL COMMENT 'Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
	WRG_ID VARCHAR(12) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	KL_ART_KAT_ID NUMBER(38,0) COMMENT 'ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_WG_ID NUMBER(38,0) COMMENT 'ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_OWG_ID NUMBER(38,0) COMMENT 'ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)',
	KL_UWG_ID NUMBER(38,0) COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	HWG_ID NUMBER(38,0) COMMENT 'ID der Hauptwarengruppe',
	OWG_ID NUMBER(38,0) COMMENT 'ID der Oberwarengruppe',
	WG_ID NUMBER(38,0) COMMENT 'ID der Warengruppe',
	WUG_ID NUMBER(38,0),
	DURCHSCHNITT_PREIS_KASSE NUMBER(18,4) COMMENT 'Durchschnittlicher VK (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)',
	UMSATZ_BRUTTO NUMBER(18,4) COMMENT 'Bruttoumsatz aus Nielsen',
	UMSATZ_BRUTTO_AF NUMBER(18,4) COMMENT 'Bruttoumsatz aktionsfrei aus Nielsen',
	UMSATZ_BRUTTO_SA NUMBER(18,4) COMMENT 'Bruttoumsatz Sonderaktion aus Nielsen',
	MENGE NUMBER(18,3) COMMENT 'Menge aus Nielsen',
	MENGE_AF NUMBER(18,3) COMMENT 'Menge aktionsfrei aus Nielsen',
	MENGE_SA NUMBER(18,3) COMMENT 'Menge Sonderaktion aus Nielsen',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sortimentstool - Aggregation von Nielsen-Artikel zum Vergleich mit Kaufland (Umsatz, Menge, Preis...) - Basisdaten Preislagen'
;