CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_NIELSEN_PREISLAGE_ZU_PER_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ART_MATCHING_ID INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden'),
KJMO INTEGER NOT NULL OPTIONS(description='Monat_2 eines Kalenderjahres, Format JJJJMM'),
WRG_ID STRING(12) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
KL_ART_KAT_ID INTEGER OPTIONS(description='ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)'),
KL_WG_ID INTEGER OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
KL_OWG_ID INTEGER OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
KL_UWG_ID INTEGER OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
HWG_ID INTEGER OPTIONS(description='ID der Hauptwarengruppe'),
OWG_ID INTEGER OPTIONS(description='ID der Oberwarengruppe'),
WG_ID INTEGER OPTIONS(description='ID der Warengruppe'),
WUG_ID INTEGER,
DURCHSCHNITT_PREIS_KASSE NUMERIC(18,4)
OPTIONS(description='Durchschnittlicher VK_2 (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
UMSATZ_BRUTTO NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aus Nielsen'),
UMSATZ_BRUTTO_AF NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aktionsfrei aus Nielsen'),
UMSATZ_BRUTTO_SA NUMERIC(18,4) OPTIONS(description='Bruttoumsatz Sonderaktion aus Nielsen'),
MENGE NUMERIC(18,3) OPTIONS(description='Menge aus Nielsen'),
MENGE_AF NUMERIC(18,3) OPTIONS(description='Menge aktionsfrei aus Nielsen'),
MENGE_SA NUMERIC(18,3) OPTIONS(description='Menge Sonderaktion aus Nielsen'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
)
OPTIONS(description='EK-INTEGER - Sortimentstool - Aggregation von Nielsen-Artikel_2 zum Vergleich mit Kaufland (Umsatz, Menge, Preis...) - Basisdaten Preislagen');