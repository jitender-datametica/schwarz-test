CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_NIELSEN_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ART_NIELSEN_ID INTEGER NOT NULL OPTIONS(description='Artikel_1-ID aus Nielsen'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum, Beginn der Gültigkeitsperiode.'),
DAT_BIS DATE NOT NULL OPTIONS(description='Datum, Ende der Gültigkeitsperiode.'),
ART_NIELSEN_TAG STRING(200) COLLATE 'und:ci' OPTIONS(description='eindeutige Artikel_1-ID aus Nielsen '),
ART_NIELSEN_BEZ STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelbezeichnung aus Nielsen '),
HERSTELLER_BEZ STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Herstellerbezeichnung aus Nielsen'),
GTIN_ID INTEGER NOT NULL OPTIONS(description='Global Trade Item_1 Number (GTIN)'),
GTIN_REF_ID STRING(500)
OPTIONS(description='Kommaseparierte Liste an GTINs für verbundene, ähnliche Artikel_1 gleichen Typs aber verschiede Varianten.'),
INHALT_MENGE STRING(120) COLLATE 'und:ci' NOT NULL OPTIONS(description='Inhaltsangabe für Artikel_1'),
INHALT_EINHEIT STRING(16) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Einheit der Inhaltsmenge des Artikel_1 (z.B. ST=Stück; G=Gramm, etc.)'),
NIELSEN_ABTEILUNG_BEZ STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nielsen Bezeichnung der Abteilung'),
NIELSEN_WG_BEZ STRING(1024) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nielsen Bezeichnung der Warengruppen'),
NIELSEN_UWG1_BEZ STRING(1024) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 1'),
NIELSEN_UWG2_BEZ STRING(1024) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 2'),
MARKE_BEZ STRING(300) OPTIONS(description='Marke des Artikels aus Quelle Nielsen.'),
BIO_ORGANIC_KZ STRING(50) OPTIONS(description='Label Bio, nicht Bio, unbekannt oder N/A, aus Quelle Nielsen.'),
VEGGY_SPLIT_KZ STRING(50) OPTIONS(description='Label Vegan, Vegetarisch, normal oder N/A, aus Quelle Nielsen.'),
LAKTOSEFREI_KZ STRING(50) OPTIONS(description='Label laktosefrei, normal oder N/A, aus Quelle Nielsen.'),
GLUTENFREI_KZ STRING(50) OPTIONS(description='Label mit Gluten, ohne Gluten oder N/A, aus Quelle Nielsen.'),
DUFT_GESCHMACK_BEZ STRING(300) OPTIONS(description='Duft / Geschmack aus Quelle Nielsen.'),
NIELSEN_VORSCHL_WG_ID INTEGER OPTIONS(description='Die von Nielsen vorgeschlagene WG-ID (Warengruppe-ID).'),
NIELSEN_VORSCHL_WUG_ID INTEGER OPTIONS(description='Die von Nielsen vorgeschlagene WUG_1-ID (Warenuntergruppe-ID).'),
DATZEIT_LETZTE_EINTRAGUNG_NIELSEN_VORSCHL TIMESTAMP
OPTIONS(description='Zeitpunkt des letzten Nielsen-Vorschlags für WG- / WUG_1-IDs. Nielsen aktualisiert den Vorhersagealgorithmus, was dazu führen kann, dass sich die Vorhersagen über die Zeit_1 verändern.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_NIELSEN_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='EK-INTEGER - Artikelstamm aus Nielsendaten (Nielsen Standard Flat File)');