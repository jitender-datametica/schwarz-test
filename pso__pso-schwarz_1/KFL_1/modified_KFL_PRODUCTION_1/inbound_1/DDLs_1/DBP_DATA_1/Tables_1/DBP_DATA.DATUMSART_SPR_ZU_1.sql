--==============================================================
-- Table: datumsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: datumsart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DATUMSART_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'PK - Mandant_1 im DWH',
   datumsart_id                        VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Datumsart, z.Bsp. 13',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   datumsart_bez                       VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Datumsart, z.Bsp. Beginn Wehrdienst',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DATUMSART_SPR_ZU PRIMARY KEY (mandant_id, datumsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'SHR - Sprachabhängige Bezeichnung der Ereignisse';

