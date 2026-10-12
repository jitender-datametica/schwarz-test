--==============================================================
-- Table: fipo_pruefpunkt_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_pruefpunkt_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_PRUEFPUNKT_SPR_ZU (
   fipo_pruefpunkt_id                  INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Prüfpunkts aus ppu_id',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   fipo_pruefpunkt_bez                 VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung eines Prüfpunkts aus dem Quellfeld ppi_pruefpunkt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_PRUEFPUNKT_SPR_ZU PRIMARY KEY (fipo_pruefpunkt_id, spr_id) NOT ENFORCED
)  COMMENT = 'FIPO - Sprachtabelle zu Prüfpunkt - Quelltabelle pruefpunkt_int';

