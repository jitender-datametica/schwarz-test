-- 20221116 twie: SPEC0166860 neue audimex View für Fragestatus

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_kmr_l_frage_status_1 (frage_status_id,
amx_system_id, frage_status_bez) AS SELECT frage_status_id,
 amx_system_id,
 frage_status_bez
FROM kfl_production_dbp_view.v_kmr_l_frage_status_1;