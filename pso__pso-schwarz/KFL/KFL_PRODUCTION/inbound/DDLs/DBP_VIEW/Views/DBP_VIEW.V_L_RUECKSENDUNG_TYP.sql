CREATE OR REPLACE VIEW DBP_VIEW.V_L_RUECKSENDUNG_TYP (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,ruecksendung_typ_kz                      COMMENT 'Code für die Art der Rücksendung.'
)
COMMENT = 'Lookup-Tabelle für Rücksendungstypen.'
 AS 
    SELECT 
        mandant_id,
        ruecksendung_typ_kz

FROM DBP_DATA.L_RUECKSENDUNG_TYP ;