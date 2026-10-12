--==============================================================
-- Table: ruecksendung_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ruecksendung_status_spr_zu_2
   generated from Powerdesigner on Freitag, 22. November 2024 11:03:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RUECKSENDUNG_STATUS_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   ruecksendung_status_id              INTEGER     NOT NULL COMMENT 'Status_2 ID der Rücklieferung.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache im DWH',
   ruecksendung_status_bez             VARCHAR(100)     NOT NULL COMMENT 'Status_2 Bezeichnung der Rücklieferung in verschiedenen Sprachen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RUECKSENDUNG_STATUS_SPR_ZU PRIMARY KEY (mandant_id, ruecksendung_status_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung für den Status_2 der Rücksendung';
