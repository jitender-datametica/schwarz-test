--==============================================================
-- Table: flw_kalk_material_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_material_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALK_MATERIAL_SPR_ZU_2 (
   materialwert_kalk_id                NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID zur Materialwertkalkulation aus clcnr',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   material_kalk_bez                   VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Materialwertkalkulation aus txt40',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALK_MATERIAL_SPR_ZU PRIMARY KEY (materialwert_kalk_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen zur Materialwertkalkulation aus clckt';

