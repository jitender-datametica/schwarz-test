CREATE OR REPLACE TABLE kfl_production_dbp_data.art_gp_zu_per (
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode\n            '),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id INTEGER NOT NULL
OPTIONS(description='Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP zusammen mit dem Attribut gp_id eindeutig zu identifizieren.  1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
gp_art_id STRING(40) COLLATE 'und:ci' DEFAULT '-1' NOT NULL OPTIONS(description='Lieferantenartikelnummer'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen:\'9999-12-31\''),
herst_id INTEGER DEFAULT - 2 NOT NULL
OPTIONS(description='Hersteller - ID\n\n            (AIS: im Artikelstamm)\n            ist zur Löschung vorgesehen, Hersteller wird in Zukunft über herst_fg im gp abgebildet'),
mhd_zeitraum_dz INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Restlaufzeit des dezentralen Artikels in Tagen\n            Erweiterung für Projekt AIS2005'),
mutter_ek_id INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleichen Einkaufspreisen ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von, mandant_id, art_id) NOT ENFORCED
) OPTIONS(description='TP2 AIS - Gibt an, welcher Lieferant zu einem Zeitpunkt für einen Artikel gueltig ist');