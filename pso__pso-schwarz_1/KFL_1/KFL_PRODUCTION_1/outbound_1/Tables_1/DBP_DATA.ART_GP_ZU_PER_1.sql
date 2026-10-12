--==============================================================
-- Table: art_gp_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gp_zu_per_1 (
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_1 zusammen mit dem Attribut gp_id eindeutig zu identifizieren.  1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
gp_art_id STRING(40) COLLATE 'und:ci' DEFAULT '-1' NOT NULL OPTIONS(description='Lieferantenartikelnummer'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen:\'9999-12-31\''),
herst_id BIGNUMERIC(38,0) DEFAULT - 2 NOT NULL
OPTIONS(description='Hersteller - ID                        (AIS: im Artikelstamm)            ist zur Löschung vorgesehen, Hersteller wird in Zukunft über herst_fg im gp_1 abgebildet'),
mhd_zeitraum_dz BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Restlaufzeit des dezentralen Artikels in Tagen            Erweiterung für Projekt AIS2005'),
mutter_ek_id BIGNUMERIC(38,0)
OPTIONS(description='Bei einer Serie von Artikeln mit gleichen Einkaufspreisen ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von, mandant_id, art_id) NOT ENFORCED
) OPTIONS(description='TP2 AIS - Gibt an, welcher Lieferant zu einem Zeitpunkt für einen Artikel_1 gueltig ist');