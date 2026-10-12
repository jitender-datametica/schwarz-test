--==============================================================
-- Table: art_gp_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GP_ZU_PER_1 (
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode
            ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT 'Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_1 zusammen mit dem Attribut gp_id eindeutig zu identifizieren.  1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   gp_art_id                           VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Lieferantenartikelnummer',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: ''9999-12-31''',
   herst_id                            INTEGER     NOT NULL DEFAULT -2 COMMENT 'Hersteller - ID
            
            (AIS: im Artikelstamm)
            ist zur Löschung vorgesehen, Hersteller wird in Zukunft über herst_fg im gp_1 abgebildet',
   mhd_zeitraum_dz                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Restlaufzeit des dezentralen Artikels in Tagen
            Erweiterung für Projekt AIS2005',
   mutter_ek_id                        INTEGER     COMMENT 'Bei einer Serie von Artikeln mit gleichen Einkaufspreisen ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GP_ZU_PER PRIMARY KEY (dat_von, mandant_id, art_id) NOT ENFORCED
)  COMMENT = 'TP2 AIS - Gibt an, welcher Lieferant zu einem Zeitpunkt für einen Artikel_1 gueltig ist';

