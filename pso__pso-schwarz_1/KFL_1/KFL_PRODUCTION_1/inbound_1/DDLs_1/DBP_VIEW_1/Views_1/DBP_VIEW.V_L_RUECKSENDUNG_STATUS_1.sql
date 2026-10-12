CREATE OR REPLACE VIEW DBP_VIEW.V_L_RUECKSENDUNG_STATUS_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,ruecksendung_status_id                   COMMENT 'Status_1 der Rücklieferung: 0 = vom System angelegt, 1 = in Bearbeitung, 2 = abgeschlossen (erfasst und freigegeben), 3 = RL-Datum kritisch, 4 = Zwangsabschluss.'
)
COMMENT = 'Lookup-Tabelle für den Status_1 der Rücksendung.'
 AS 
    SELECT 
        mandant_id,
        ruecksendung_status_id

FROM DBP_DATA.L_RUECKSENDUNG_STATUS_1 ;