CREATE OR REPLACE VIEW DBP_VIEW.V_L_ANGEBOT_STATUS (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,angebot_status_id                        COMMENT 'ID des Angebotstatus'
)
COMMENT = 'Lookuptabelle der möglichen Status des Angebots.'
 AS 
    SELECT 
        mandant_id,
        angebot_status_id
FROM DBP_DATA.L_ANGEBOT_STATUS ;