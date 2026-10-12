CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_massnahme (amx_system_id, massnahme_id, feststellung_id,
massnahme_txt, zustaendige_stelle_id, massnahme_status_id, antwort_auditor_abwartend_fg, dat_umsetzung_angelegt,
dat_umsetzung_geplant, dat_umsetzung_erledigt, verschiebungen_anz) AS SELECT amx_system_id,
 massnahme_id,
 feststellung_id,
 massnahme_txt,
 zustaendige_stelle_id,
 massnahme_status_id,
 antwort_auditor_abwartend_fg,
 dat_umsetzung_angelegt,
 dat_umsetzung_geplant,
 dat_umsetzung_erledigt,
 verschiebungen_anz
FROM kfl_production_dbp_data.kmr_massnahme;