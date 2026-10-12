--==============================================================
-- Table: flw_l_vkorg_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_vkorg_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_VKORG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_verkaufsorganisation_id         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsorganisation aus vkorg',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_VKORG PRIMARY KEY (mandant_id, flw_verkaufsorganisation_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup- Tabelle Verkaufsorganisation- SAP Tabelle TVKOT';

