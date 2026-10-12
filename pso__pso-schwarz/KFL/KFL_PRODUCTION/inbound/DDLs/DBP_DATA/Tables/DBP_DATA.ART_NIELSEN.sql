--==============================================================
-- Table: art_nielsen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen
   generated from Powerdesigner on Freitag, 28. April 2023 16:53:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   art_nielsen_id                      NUMBER(38,0)     NOT NULL COMMENT 'Artikel-ID aus Nielsen',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, Beginn der Gültigkeitsperiode.',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, Ende der Gültigkeitsperiode.',
   art_nielsen_tag                     VARCHAR(200)     COLLATE 'en-ci' COMMENT 'eindeutige Artikel-ID aus Nielsen ',
   art_nielsen_bez                     VARCHAR(1024)    NOT NULL COLLATE 'en-ci' COMMENT 'Artikelbezeichnung aus Nielsen ',
   hersteller_bez                      VARCHAR(1024)    NOT NULL COLLATE 'en-ci' COMMENT 'Herstellerbezeichnung aus Nielsen',
   gtin_id                             NUMBER(38,0)     NOT NULL COMMENT 'Global Trade Item Number (GTIN)',
   gtin_ref_id                         VARCHAR(500)     COMMENT 'Kommaseparierte Liste an GTINs für verbundene, ähnliche Artikel gleichen Typs aber verschiede Varianten.',
   inhalt_menge                        VARCHAR(120)     NOT NULL COLLATE 'en-ci' COMMENT 'Inhaltsangabe für Artikel',
   inhalt_einheit                      VARCHAR(16)      NOT NULL COLLATE 'en-ci' COMMENT 'Einheit der Inhaltsmenge des Artikel (z.B. ST=Stück; G=Gramm, etc.)',
   nielsen_abteilung_bez               VARCHAR(1024)    NOT NULL COLLATE 'en-ci' COMMENT 'Nielsen Bezeichnung der Abteilung',
   nielsen_wg_bez                      VARCHAR(1024)    NOT NULL COLLATE 'en-ci' COMMENT 'Nielsen Bezeichnung der Warengruppen',
   nielsen_uwg1_bez                    VARCHAR(1024)    NOT NULL COLLATE 'en-ci' COMMENT 'Nielsen Bezeichnung der Unterwarengruppe 1',
   nielsen_uwg2_bez                    VARCHAR(1024)    NOT NULL COLLATE 'en-ci' COMMENT 'Nielsen Bezeichnung der Unterwarengruppe 2',
   marke_bez                           VARCHAR(300)     COMMENT 'Marke des Artikels aus Quelle Nielsen.',
   bio_organic_kz                      VARCHAR(50)      COMMENT 'Label Bio, nicht Bio, unbekannt oder N/A, aus Quelle Nielsen.',
   veggy_split_kz                      VARCHAR(50)      COMMENT 'Label Vegan, Vegetarisch, normal oder N/A, aus Quelle Nielsen.',
   laktosefrei_kz                      VARCHAR(50)      COMMENT 'Label laktosefrei, normal oder N/A, aus Quelle Nielsen.',
   glutenfrei_kz                       VARCHAR(50)      COMMENT 'Label mit Gluten, ohne Gluten oder N/A, aus Quelle Nielsen.',
   duft_geschmack_bez                  VARCHAR(300)     COMMENT 'Duft / Geschmack aus Quelle Nielsen.',
   nielsen_vorschl_wg_id               NUMBER(38,0)     COMMENT 'Die von Nielsen vorgeschlagene WG-ID (Warengruppe-ID).',
   nielsen_vorschl_wug_id              NUMBER(38,0)     COMMENT 'Die von Nielsen vorgeschlagene WUG-ID (Warenuntergruppe-ID).',
   datzeit_letzte_eintragung_nielsen_vorschl TIMESTAMP_LTZ(9) COMMENT 'Zeitpunkt des letzten Nielsen-Vorschlags für WG- / WUG-IDs. Nielsen aktualisiert den Vorhersagealgorithmus, was dazu führen kann, dass sich die Vorhersagen über die Zeit verändern.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN PRIMARY KEY (mandant_id, art_nielsen_id, dat_von) NOT ENFORCED
)  COMMENT = 'EK-INT - Artikelstamm aus Nielsendaten (Nielsen Standard Flat File)'
;
