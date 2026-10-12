--==============================================================
-- Table: art_attribut_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_attribut_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_ATTRIBUT_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_attribut_id                     VARCHAR(5)       NOT NULL COLLATE 'en-ci' DEFAULT '     ' COMMENT 'Artikelattribut',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache',
   art_attribut_bez                    VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Artikelattribut Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_ATTRIBUT_SPR_ZU PRIMARY KEY (mandant_id, art_attribut_id, spr_id) NOT ENFORCED
)  COMMENT = 'Artikelattributtexte';

