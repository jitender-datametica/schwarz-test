--==============================================================
-- Table: art_backen_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backen_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKEN_SPR_ZU_1 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   art_backen_bez                      VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Artikelbezeichnung speziell für den Backshop',
   feierabend_fg                       INTEGER     NOT NULL DEFAULT 0,
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKEN_SPR_ZU PRIMARY KEY (art_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Im Backshop werden von den Stammdaten abweichende Artikelbezeichnungen verwendet';

