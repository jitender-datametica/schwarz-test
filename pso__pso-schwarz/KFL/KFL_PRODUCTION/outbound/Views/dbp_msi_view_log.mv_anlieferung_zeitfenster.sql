CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_anlieferung_zeitfenster (mercareon_standort,
mercareon_entladestelle, dat, zeit, anz_zf_gesamt, anz_zf_gebucht, anz_zf_reserviert, anz_zf_gesperrt, anz_zf_frei) AS
SELECT mercareon_standort,
 mercareon_entladestelle,
 dat,
 zeit,
 anz_zf_gesamt,
 anz_zf_gebucht,
 anz_zf_reserviert,
 anz_zf_gesperrt,
 anz_zf_frei
FROM kfl_production_dbp_view.v_anlieferung_zeitfenster;