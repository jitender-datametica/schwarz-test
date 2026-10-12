--==============================================================
-- Table: nl_listung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nl_listung_1
   generated from Powerdesigner on Freitag, 8. Oktober 2021 10:44:41
*/ --------------------------------------------------------------------------------


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.nl_listung_1 (
nl_listung_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Automatischer generierter Schluessel'),
mandant_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL OPTIONS(description='Mandant_1 im DWH'),
listung_art STRING(100) NOT NULL
OPTIONS(description='Vorschlagswert bezueglich Listung aus Stored Procedure (z.B. Listung erweitern)'),
sm_id_selected BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sortimentsmodul ID. Es gibt 5 Sortimentsstufen, von 1 bis 5. -1: keine Sortimentsstufe zugeordnet'),
sm_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sortimentsmodul ID'),
gtin STRING(300) COLLATE 'und:ci' NOT NULL OPTIONS(description='Global Trade Item_1 Number (GTIN)'),
ost_basis STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
ost_gross STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
sued_ost STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
sued_west STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
west STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
nord STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Listungsinformation abgeleitet aus SAL (Sternchenlogik)'),
kl_owg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Oberwarengruppe fuer Nielsen-Daten (Vergabe im Beladeprozess)'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
art_nielsen_bez STRING(500) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung aus Nielsen '),
umsatz_artikel NUMERIC(18,4) OPTIONS(description='Gesamtumsatz'),
durchschnitt_anz_maerkte BIGNUMERIC(38,0) OPTIONS(description='Durschnittliche Anzahl Maerkte (Nielsen Daten)'),
durchschnitt_preis NUMERIC(18,4)
OPTIONS(description='Durchschnittlicher VK_1 (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
anz_wochen BIGNUMERIC(38,0) OPTIONS(description='Anzahl Wochen'),
anz_maerkte BIGNUMERIC(38,0) OPTIONS(description='Anzahl gelistete Maerkte  (wird im ETL-Prozess ermittelt)'),
umsatz_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
absatz_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
kjwo_update BIGNUMERIC(38,0) OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY sm_id_selected, kjwo_update
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Tabelle fuer Zwischenablage der Hochrechnungsergebnisse Nielsen-Artikel_1');