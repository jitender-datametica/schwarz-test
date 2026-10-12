--==============================================================
-- Table: fw_reserve_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_reserve_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FW_RESERVE_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   fw_reserve_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'ID für die Kennzeichnung Artikel_2  Fleischwerk Reserve  aus dem Quellfeld zfwbestvor',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   fw_reserve_bez                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für das Artikelkennzeichen Fleischwerk reserve  aus dem Quellfeld Text, z.Bsp. keine',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FW_RESERVE_SPR_ZU PRIMARY KEY (mandant_id, fw_reserve_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Fleischwerk Reserve Artikelkennzeichen aus der Retail Tabelle  zfwprbeste';

