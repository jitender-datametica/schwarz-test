CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_nielsen_preislage_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
wrg_id STRING(12) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
kl_art_kat_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_wg_id BIGNUMERIC(38,0) OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_owg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_uwg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
hwg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Hauptwarengruppe'),
owg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Oberwarengruppe'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0),
durchschnitt_preis_kasse NUMERIC(18,4)
OPTIONS(description='Durchschnittlicher VK (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
umsatz_brutto NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aus Nielsen'),
umsatz_brutto_af NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aktionsfrei aus Nielsen'),
umsatz_brutto_sa NUMERIC(18,4) OPTIONS(description='Bruttoumsatz Sonderaktion aus Nielsen'),
menge NUMERIC(18,3) OPTIONS(description='Menge aus Nielsen'),
menge_af NUMERIC(18,3) OPTIONS(description='Menge aktionsfrei aus Nielsen'),
menge_sa NUMERIC(18,3) OPTIONS(description='Menge Sonderaktion aus Nielsen'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sortimentstool - Aggregation von Nielsen-Artikel zum Vergleich mit Kaufland (Umsatz, Menge, Preis...) - Basisdaten Preislagen');