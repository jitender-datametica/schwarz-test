--==============================================================
-- Table: art_wup_tag_gld
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_tag_gld
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_TAG_GLD (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   ek_gld                              NUMBER(18,4)     COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_TAG_GLD PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Zur Anreicherung der Tabelle artbew mit gld. Die Daten werden aus lagerbew_det gewonnen und für begrenzte Zeit in dieser Tabelle abgelegt - MULTISET.';

