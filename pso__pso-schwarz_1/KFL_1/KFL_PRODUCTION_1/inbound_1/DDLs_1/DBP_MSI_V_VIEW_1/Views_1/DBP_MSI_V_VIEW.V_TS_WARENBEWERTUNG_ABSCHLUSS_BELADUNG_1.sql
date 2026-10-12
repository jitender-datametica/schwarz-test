CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_WARENBEWERTUNG_ABSCHLUSS_BELADUNG_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH.'
  ,dat_aenderung                            COMMENT 'Das Datum, an dem die Änderungen vorgenommen wurden.'
  ,job_start_fg                             COMMENT 'Flag ob Beladungsjob rueckwirkend für die dat_aenderung gestartet werden sollte. 0 - Job soll nicht gestartet werden , 1 - Job soll gestartet werden.'
)
COMMENT = 'Die Tabelle dient als Steuerung für die rückwirkende Beladung der Tabelle dbp_data.warenbewertung_abschluss.FB trägt für welches Datum und Land_1, Änderungen vorgekommen sind, ein und diese sollten in der Tabelle nachbeladen werden (es dreht nicht um die "normale" Beladung ).'
 AS 
    SELECT 
        mandant_id,
        dat_aenderung,
        job_start_fg

FROM DBP_MSI_DATA.TS_WARENBEWERTUNG_ABSCHLUSS_BELADUNG_1 ;