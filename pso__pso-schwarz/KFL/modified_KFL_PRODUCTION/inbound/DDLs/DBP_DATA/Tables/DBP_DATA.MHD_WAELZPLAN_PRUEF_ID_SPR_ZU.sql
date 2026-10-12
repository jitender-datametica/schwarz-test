--==============================================================
-- Table: mhd_waelzplan_pruef_id_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mhd_waelzplan_pruef_id_spr_zu
   generated from Powerdesigner on Mittwoch, 14. Dezember 2022 15:44:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MHD_WAELZPLAN_PRUEF_ID_SPR_ZU (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   waelzplan_pruef_id                  INTEGER    NOT NULL COMMENT 'Prüf-ID für den Wälzplan.',
   spr_id                              INTEGER    NOT NULL COMMENT 'ID der Sprache',
   waelzplan_pruef_bez                 VARCHAR(200)    COMMENT 'Beschreibung der Prüf-ID.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MHD_WAELZPLAN_PRUEF_ID_SPR_ZU PRIMARY KEY (mandant_id, spr_id, waelzplan_pruef_id) NOT ENFORCED
)  COMMENT = 'Lookuptabelle für die Übersetzungen der Prüf-IDs für den Wälzplan.';