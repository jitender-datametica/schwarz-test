CREATE OR REPLACE VIEW DBP_VIEW.V_RUECKSENDUNG_STATUS_SPR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,ruecksendung_status_id                   COMMENT 'Status_1 ID der Rücklieferung.'
  ,spr_id                                   COMMENT 'Sprache im DWH'
  ,ruecksendung_status_bez                  COMMENT 'Status_1 Bezeichnung der Rücklieferung in verschiedenen Sprachen.'
)
COMMENT = 'Sprachabhängige Bezeichnung für den Status_1 der Rücksendung'
 AS 
    SELECT 
        mandant_id,
        ruecksendung_status_id,
        spr_id,
        ruecksendung_status_bez

FROM DBP_DATA.RUECKSENDUNG_STATUS_SPR_ZU_1 ;