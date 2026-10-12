--==============================================================
-- Table: mhd_waelzplan_pruef_id_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mhd_waelzplan_pruef_id_spr_zu_1
   generated from Powerdesigner on Mittwoch, 14. Dezember 2022 15:44:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MHD_WAELZPLAN_PRUEF_ID_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   waelzplan_pruef_id                  NUMBER(38,0)    NOT NULL COMMENT 'Prüf-ID für den Wälzplan.',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Sprache',
   waelzplan_pruef_bez                 VARCHAR(200)    COMMENT 'Beschreibung der Prüf-ID.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MHD_WAELZPLAN_PRUEF_ID_SPR_ZU PRIMARY KEY (mandant_id, spr_id, waelzplan_pruef_id) NOT ENFORCED
)  COMMENT = 'Lookuptabelle für die Übersetzungen der Prüf-IDs für den Wälzplan.';