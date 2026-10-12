--==============================================================
-- Table: art_back_hinweis_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_back_hinweis_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACK_HINWEIS_ZU_1 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   back_hinweis_id                     INTEGER     NOT NULL COMMENT 'eindeutige ID für den Back-Hinweis aus dem Quellfeld ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACK_HINWEIS_ZU PRIMARY KEY (art_id, mandant_id, back_hinweis_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Zuordnung von Backhinweisen zu Artikeln';

