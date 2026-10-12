CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_GP_ZU_PER_1 (
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode\n            '),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
EINKAUFSORGANISATION_ID INTEGER NOT NULL
OPTIONS(description='Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_1 zusammen mit dem Attribut gp_id eindeutig zu identifizieren.  1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
GP_ART_ID STRING(40) COLLATE 'und:ci' DEFAULT '-1' NOT NULL OPTIONS(description='Lieferantenartikelnummer'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: 9999-12-31'),
HERST_ID INTEGER DEFAULT - 2 NOT NULL
OPTIONS(description='Hersteller - ID\n\n            (AIS: im Artikelstamm)\n            ist zur Löschung vorgesehen, Hersteller wird in Zukunft über herst_fg im gp_1 abgebildet'),
MHD_ZEITRAUM_DZ INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Restlaufzeit des dezentralen Artikels in Tagen\n            Erweiterung für Projekt AIS2005'),
MUTTER_EK_ID INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleichen Einkaufspreisen ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (DAT_VON, MANDANT_ID, ART_ID) NOT ENFORCED
) OPTIONS(description='TP2 AIS - Gibt an, welcher Lieferant zu einem Zeitpunkt für einen Artikel_1 gueltig ist');