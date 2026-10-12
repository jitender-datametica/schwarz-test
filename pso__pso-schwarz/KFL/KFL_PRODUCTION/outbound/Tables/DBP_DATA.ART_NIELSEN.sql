--==============================================================
-- Table: art_nielsen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen
   generated from Powerdesigner on Freitag, 28. April 2023 16:53:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_nielsen (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel-ID aus Nielsen'),
dat_von DATE NOT NULL OPTIONS(description='Datum, Beginn der Gültigkeitsperiode.'),
dat_bis DATE NOT NULL OPTIONS(description='Datum, Ende der Gültigkeitsperiode.'),
art_nielsen_tag STRING(200) COLLATE 'und:ci' OPTIONS(description='eindeutige Artikel-ID aus Nielsen '),
art_nielsen_bez STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelbezeichnung aus Nielsen '),
hersteller_bez STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Herstellerbezeichnung aus Nielsen'),
gtin_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Global Trade Item Number (GTIN)'),
gtin_ref_id STRING(500)
OPTIONS(description='Kommaseparierte Liste an GTINs für verbundene, ähnliche Artikel gleichen Typs aber verschiede Varianten.'),
inhalt_menge STRING(120) COLLATE 'und:ci' NOT NULL OPTIONS(description='Inhaltsangabe für Artikel'),
inhalt_einheit STRING(16) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Einheit der Inhaltsmenge des Artikel (z.B. ST=Stück; G=Gramm, etc.)'),
nielsen_abteilung_bez STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nielsen Bezeichnung der Abteilung'),
nielsen_wg_bez STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nielsen Bezeichnung der Warengruppen'),
nielsen_uwg1_bez STRING(1024) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 1'),
nielsen_uwg2_bez STRING(1024) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 2'),
marke_bez STRING(300) OPTIONS(description='Marke des Artikels aus Quelle Nielsen.'),
bio_organic_kz STRING(50) OPTIONS(description='Label Bio, nicht Bio, unbekannt oder N/A, aus Quelle Nielsen.'),
veggy_split_kz STRING(50) OPTIONS(description='Label Vegan, Vegetarisch, normal oder N/A, aus Quelle Nielsen.'),
laktosefrei_kz STRING(50) OPTIONS(description='Label laktosefrei, normal oder N/A, aus Quelle Nielsen.'),
glutenfrei_kz STRING(50) OPTIONS(description='Label mit Gluten, ohne Gluten oder N/A, aus Quelle Nielsen.'),
duft_geschmack_bez STRING(300) OPTIONS(description='Duft / Geschmack aus Quelle Nielsen.'),
nielsen_vorschl_wg_id BIGNUMERIC(38,0) OPTIONS(description='Die von Nielsen vorgeschlagene WG-ID (Warengruppe-ID).'),
nielsen_vorschl_wug_id BIGNUMERIC(38,0)
OPTIONS(description='Die von Nielsen vorgeschlagene WUG-ID (Warenuntergruppe-ID).'),
datzeit_letzte_eintragung_nielsen_vorschl TIMESTAMP
OPTIONS(description='Zeitpunkt des letzten Nielsen-Vorschlags für WG- / WUG-IDs. Nielsen aktualisiert den Vorhersagealgorithmus, was dazu führen kann, dass sich die Vorhersagen über die Zeit verändern.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_nielsen_id, dat_von) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Artikelstamm aus Nielsendaten (Nielsen Standard Flat File)');