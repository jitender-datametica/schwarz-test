--==============================================================
-- Table: flw_vw_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_vw_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_VW_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_vw_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   vw_bez                              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Vertriebswegs aus vtext',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_VW_SPR_ZU PRIMARY KEY (mandant_id, flw_vw_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Vertriebswege aus tvtwt';

