--==============================================================
-- Table: art_wup_tag_gld_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_tag_gld_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_TAG_GLD_2 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
   ek_gld                              NUMBER(29,4)     COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_TAG_GLD PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Zur Anreicherung der Tabelle artbew_2 mit gld. Die Daten werden aus lagerbew_det_2 gewonnen und für begrenzte Zeit_2 in dieser Tabelle abgelegt - MULTISET.';

