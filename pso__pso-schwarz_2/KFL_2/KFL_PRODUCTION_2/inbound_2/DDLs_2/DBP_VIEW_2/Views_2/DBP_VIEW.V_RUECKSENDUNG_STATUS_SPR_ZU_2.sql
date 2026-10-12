CREATE OR REPLACE VIEW DBP_VIEW.V_RUECKSENDUNG_STATUS_SPR_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,ruecksendung_status_id                   COMMENT 'Status_2 ID der Rücklieferung.'
  ,spr_id                                   COMMENT 'Sprache im DWH'
  ,ruecksendung_status_bez                  COMMENT 'Status_2 Bezeichnung der Rücklieferung in verschiedenen Sprachen.'
)
COMMENT = 'Sprachabhängige Bezeichnung für den Status_2 der Rücksendung'
 AS 
    SELECT 
        mandant_id,
        ruecksendung_status_id,
        spr_id,
        ruecksendung_status_bez

FROM DBP_DATA.RUECKSENDUNG_STATUS_SPR_ZU_2 ;