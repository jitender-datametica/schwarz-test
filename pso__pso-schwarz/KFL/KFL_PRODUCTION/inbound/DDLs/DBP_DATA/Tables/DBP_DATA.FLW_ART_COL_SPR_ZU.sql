--==============================================================
-- Table: flw_art_col_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_col_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_COL_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   flw_art_col_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Attributs - hier Artikelhierarchiestufe - eine Zahl zwischen 1 und 7',
   art_col_auspr                       VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'Ausprägung des Attributs/ der Stufe, z.Bsp FFERT oder 01',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   art_col_bez                         VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Attributs, z.Bsp. Rind',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_COL_SPR_ZU PRIMARY KEY (mandant_id, flw_art_col_id, art_col_auspr, spr_id) NOT ENFORCED
)  COMMENT = 'FLW -Bezeichnungen der Attribute der Artikelstammdaten (Produkthierarchiestufen)';

