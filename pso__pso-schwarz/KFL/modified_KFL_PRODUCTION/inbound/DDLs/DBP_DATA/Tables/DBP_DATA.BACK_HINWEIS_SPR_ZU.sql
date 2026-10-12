--==============================================================
-- Table: back_hinweis_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_hinweis_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BACK_HINWEIS_SPR_ZU (
   back_hinweis_id                     INTEGER     NOT NULL COMMENT 'eindeutige ID für den Back-Hinweis aus dem Quellfeld ID',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   back_hinweis_bez                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung für den Back-Hinweis aus dem Quellfeld bake_info, z.Bsp. "Tiefgekühlt backen"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BACK_HINWEIS_SPR_ZU PRIMARY KEY (back_hinweis_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Sprachabhängige Bezeichnungen der Back-Hinweise aus der SAP Z-Tabelle zek_bake_info';

