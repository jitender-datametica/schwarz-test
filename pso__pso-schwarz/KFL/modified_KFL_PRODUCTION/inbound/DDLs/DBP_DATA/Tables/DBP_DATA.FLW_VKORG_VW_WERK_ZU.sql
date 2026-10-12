--==============================================================
-- Table: flw_vkorg_vw_werk_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_vkorg_vw_werk_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_VKORG_VW_WERK_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   flw_verkaufsorganisation_id         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsorganisation aus vkorg',
   flw_vw_id                           INTEGER     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_VKORG_VW_WERK_ZU PRIMARY KEY (mandant_id, flw_verkaufsorganisation_id, flw_vw_id, werk_id) NOT ENFORCED
)  COMMENT = 'FLW - Zuordnung Vertriebsweg - Verkaufsorganisation - Werk aus tvkwz';

