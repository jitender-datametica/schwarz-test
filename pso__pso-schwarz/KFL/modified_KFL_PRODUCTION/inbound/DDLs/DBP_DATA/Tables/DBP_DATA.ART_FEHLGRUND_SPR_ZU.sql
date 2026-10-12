--==============================================================
-- Table: art_fehlgrund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_fehlgrund_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_FEHLGRUND_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_fehlgrund_id                    INTEGER     NOT NULL COMMENT 'eindeutige ID für den Fehlgrund eines Artikels',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   art_fehlgrund_bez                   VARCHAR(80)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für den Fehlgrund eines Artikels',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_FEHLGRUND_SPR_ZU PRIMARY KEY (mandant_id, art_fehlgrund_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS MK - Sprachabhängige Bezeichnung der Fehlgründe';

