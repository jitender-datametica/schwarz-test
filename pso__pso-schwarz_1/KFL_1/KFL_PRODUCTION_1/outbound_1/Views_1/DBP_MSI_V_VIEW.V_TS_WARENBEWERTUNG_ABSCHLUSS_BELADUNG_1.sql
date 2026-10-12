CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_warenbewertung_abschluss_beladung_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), dat_aenderung
OPTIONS(description='Das Datum, an dem die Änderungen vorgenommen wurden.'), job_start_fg
OPTIONS(description='Flag ob Beladungsjob rueckwirkend für die dat_aenderung gestartet werden sollte. 0 - Job soll nicht gestartet werden , 1 - Job soll gestartet werden.'))
OPTIONS(DESCRIPTION = `DIE TABELLE DIENT ALS STEUERUNG FÜR DIE RÜCKWIRKENDE BELADUNG DER TABELLE DBP_DATA.WARENBEWERTUNG_ABSCHLUSS.FB TRÄGT FÜR WELCHES DATUM UND LAND_1, ÄNDERUNGEN VORGEKOMMEN SIND, EIN UND DIESE SOLLTEN IN DER TABELLE NACHBELADEN WERDEN (ES DREHT NICHT UM DIE "NORMALE" BELADUNG ).`)
AS SELECT mandant_id,
 dat_aenderung,
 job_start_fg
FROM kfl_production_dbp_msi_data.ts_warenbewertung_abschluss_beladung_1;