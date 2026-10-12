--==============================================================
-- Table: wbs_referenzartikel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_referenzartikel
   generated from Powerdesigner on Montag, 19. September 2022 10:58:03
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_REFERENZARTIKEL (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   ref_art_id                          INTEGER    NOT NULL COMMENT 'Artikel-ID des Referenzartikels',
   ref_anz_maerkte                     INTEGER    COMMENT 'ref_anz_maerkte',
   avg_vk_brutto                       NUMBER(29,4)    COMMENT 'Preis (avg) des Fokusartikels',
   avg_ref_vk_brutto                   NUMBER(29,4)    COMMENT 'Preis (avg) des Referenzartikels',
   ref_score_rang                      INTEGER    COMMENT 'Rang der Ähnlichkeit.',
   ref_score                           NUMBER(29,4)    COMMENT 'Referenzscore aus Formel,  bei TYP=\"Missing\" werden Ähnlichkeit & Absatzdifferenz nicht verwendet.',
   diff_vk                             NUMBER(29,4)    COMMENT 'Preisdifferenz der Mittleren Preise von Ref- & Fokusartikel',
   diff_absatz                         NUMBER(29,4)    COMMENT 'Differenz mittlerer Absatz',
   diff_absatz_absolut                 NUMBER(29,4)    COMMENT 'Differenz mittlerer Absatz (Absolut)',
   diff_absatz_kennz                   VARCHAR(1)      COMMENT 'Kennzeichen, ob Absatzdifferenz Positiv / negativ ist.',
   diff_cosinus                        NUMBER(29,4)    COMMENT 'Cosinusähnlichkeit, aus W2V-Modell',
   diff_gewicht                        NUMBER(29,4)    COMMENT 'Differenz Gewicht',
   diff_wug                            NUMBER(29,4)    COMMENT 'Differenz Warenuntergruppe',
   aktion_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr',
   ref_ltz_dat_von                     DATE            COMMENT 'Start letzte Promowoche des Referenzartikels',
   dat_von                             DATE            NOT NULL COMMENT 'YYYY-MM-DD // Aktion gültig (von)',
   ltz_dat_von                         DATE            COMMENT 'Start letzte Promowoche des Fokusartikels',
   berechnung_typ                      VARCHAR(100)    COMMENT 'Kennzeichnung, der Berechnungsgrundlage zu Evaluation: missing == nicht im W2V-Modell vorhandensearch == extrahiert aus W2V-Modell',
   dat_berechnung                      TIMESTAMP_LTZ(9) COMMENT 'Berechnungszeitpunkt des Berichts',
   selektor_fg                         INTEGER    COMMENT 'Artikel für Report geeignet.',
   berechnung_subtyp                   VARCHAR(100)    COMMENT 'Subtyp',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_REFERENZARTIKEL PRIMARY KEY (mandant_id, art_id, ref_art_id, dat_von) NOT ENFORCED
)  COMMENT = 'table is used in WBS-context. It contains information of promotional articles and the reference-articles which are used to calculate and adjust promotional amounts';
