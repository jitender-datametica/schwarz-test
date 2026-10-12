--==============================================================
-- Table: flw_art_col_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_col_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_COL_ZU_1 (
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   flw_art_col_id                      INTEGER     NOT NULL COMMENT 'ID des Attributs - hier Artikelhierarchiestufe - eine_1 Zahl zwischen 1 und 7',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_col_auspr                       VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'Ausprägung des Attributs/ der Stufe, z.Bsp FFERT oder 01',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_COL_ZU PRIMARY KEY (flw_art_id, flw_art_col_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Zuordnung von Attributen zum Artikelstamm (hier Elemente der Produkthierarchie)';

