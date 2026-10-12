--==============================================================
-- Table: wbs_referenzartikel_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_referenzartikel_2
   generated from Powerdesigner on Montag, 19. September 2022 10:58:03
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_REFERENZARTIKEL_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   ref_art_id                          NUMBER(38,0)    NOT NULL COMMENT 'Artikel_2-ID des Referenzartikels',
   ref_anz_maerkte                     NUMBER(38,0)    COMMENT 'ref_anz_maerkte',
   avg_vk_brutto                       NUMBER(38,4)    COMMENT 'Preis (avg) des Fokusartikels',
   avg_ref_vk_brutto                   NUMBER(38,4)    COMMENT 'Preis (avg) des Referenzartikels',
   ref_score_rang                      NUMBER(38,0)    COMMENT 'Rang der Ähnlichkeit.',
   ref_score                           NUMBER(38,4)    COMMENT 'Referenzscore aus Formel,  bei TYP=\"Missing\" werden Ähnlichkeit & Absatzdifferenz nicht verwendet.',
   diff_vk                             NUMBER(38,4)    COMMENT 'Preisdifferenz der Mittleren Preise von Ref- & Fokusartikel',
   diff_absatz                         NUMBER(38,4)    COMMENT 'Differenz mittlerer Absatz',
   diff_absatz_absolut                 NUMBER(38,4)    COMMENT 'Differenz mittlerer Absatz (Absolut)',
   diff_absatz_kennz                   VARCHAR(1)      COMMENT 'Kennzeichen, ob Absatzdifferenz Positiv / negativ ist.',
   diff_cosinus                        NUMBER(38,4)    COMMENT 'Cosinusähnlichkeit, aus W2V-Modell',
   diff_gewicht                        NUMBER(38,4)    COMMENT 'Differenz Gewicht',
   diff_wug                            NUMBER(38,4)    COMMENT 'Differenz Warenuntergruppe',
   aktion_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr',
   ref_ltz_dat_von                     DATE            COMMENT 'Start letzte Promowoche des Referenzartikels',
   dat_von                             DATE            NOT NULL COMMENT 'YYYY-MM_2-DD // Aktion_2 gültig (von)',
   ltz_dat_von                         DATE            COMMENT 'Start letzte Promowoche des Fokusartikels',
   berechnung_typ                      VARCHAR(100)    COMMENT 'Kennzeichnung, der Berechnungsgrundlage zu Evaluation: missing == nicht im W2V-Modell vorhandensearch == extrahiert aus W2V-Modell',
   dat_berechnung                      TIMESTAMP_LTZ(9) COMMENT 'Berechnungszeitpunkt des Berichts',
   selektor_fg                         NUMBER(38,0)    COMMENT 'Artikel_2 für Report geeignet.',
   berechnung_subtyp                   VARCHAR(100)    COMMENT 'Subtyp',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_REFERENZARTIKEL PRIMARY KEY (mandant_id, art_id, ref_art_id, dat_von) NOT ENFORCED
)  COMMENT = 'table is used in WBS-context. It contains information of promotional articles and the reference-articles which are used to calculate and adjust promotional amounts';
