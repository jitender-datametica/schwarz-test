--==============================================================
-- Table: art_back_hinweis_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_back_hinweis_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACK_HINWEIS_ZU_2 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   back_hinweis_id                     INTEGER     NOT NULL COMMENT 'eindeutige ID für den Back-Hinweis aus dem Quellfeld ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACK_HINWEIS_ZU PRIMARY KEY (art_id, mandant_id, back_hinweis_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Zuordnung von Backhinweisen zu Artikeln';

