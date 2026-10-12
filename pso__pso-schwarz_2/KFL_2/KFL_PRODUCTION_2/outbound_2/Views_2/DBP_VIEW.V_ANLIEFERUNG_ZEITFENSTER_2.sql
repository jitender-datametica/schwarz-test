CREATE OR REPLACE VIEW kfl_production_dbp_view.v_anlieferung_zeitfenster_2 AS SELECT mercareon_standort,
 mercareon_entladestelle,
 dat,
 zeit_2,
 anz_zf_gesamt,
 anz_zf_gebucht,
 anz_zf_reserviert,
 anz_zf_gesperrt,
 anz_zf_frei
FROM kfl_production_dbp_data.anlieferung_zeitfenster_2;