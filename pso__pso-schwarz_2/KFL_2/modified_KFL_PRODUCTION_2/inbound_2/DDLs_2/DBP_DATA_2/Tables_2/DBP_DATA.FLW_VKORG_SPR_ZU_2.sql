--==============================================================
-- Table: flw_vkorg_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_vkorg_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_VKORG_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_verkaufsorganisation_id         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsorganisation aus vkorg',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   verkaufsorganisation_bez            VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung aus vtxtk',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_VKORG_SPR_ZU PRIMARY KEY (mandant_id, flw_verkaufsorganisation_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der  Verkaufsorganisation aus der SAP Tabelle TVKOT';

