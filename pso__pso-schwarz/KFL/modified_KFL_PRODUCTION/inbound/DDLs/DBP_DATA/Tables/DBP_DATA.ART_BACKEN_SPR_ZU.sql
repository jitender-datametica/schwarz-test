--==============================================================
-- Table: art_backen_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backen_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKEN_SPR_ZU (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   art_backen_bez                      VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Artikelbezeichnung speziell für den Backshop',
   feierabend_fg                       INTEGER     NOT NULL DEFAULT 0,
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKEN_SPR_ZU PRIMARY KEY (art_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Im Backshop werden von den Stammdaten abweichende Artikelbezeichnungen verwendet';

