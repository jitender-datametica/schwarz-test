CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_massnahme_1 (amx_system_id, massnahme_id, massnahme_txt,
dat_umsetzung_angelegt, dat_umsetzung_geplant, antwort_auditor_abwartend_fg, feststellung_id, zustaendige_stelle_id,
dat_umsetzung_erledigt, verschiebungen_anz, massnahme_status_id) AS SELECT amx_system_id,
 massnahme_id,
 massnahme_txt,
 dat_umsetzung_angelegt,
 dat_umsetzung_geplant,
 antwort_auditor_abwartend_fg,
 feststellung_id,
 zustaendige_stelle_id,
 dat_umsetzung_erledigt,
 verschiebungen_anz,
 massnahme_status_id
FROM kfl_production_dbp_view.v_kmr_massnahme_1;