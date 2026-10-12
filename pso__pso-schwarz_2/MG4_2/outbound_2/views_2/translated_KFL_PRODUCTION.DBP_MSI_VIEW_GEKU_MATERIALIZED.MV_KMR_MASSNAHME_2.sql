-- 20230817 twie: SPEC0195708 neues Feld massnahme_status_id

-- 20220112 twie: SPEC0173748 neue audimex View für Massnahme

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_massnahme_2 (amx_system_id, massnahme_id, massnahme_txt,
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
FROM kfl_production_dbp_view.v_kmr_massnahme_2;