CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_mdl_frage_antwort_zu (frage_id, antwort_id,
sec_kz, nok_fg) AS SELECT frage_id,
 antwort_id,
 1 AS sec_kz,
 nok_fg
FROM kfl_production_dbp_view.v_mdl_frage_antwort_zu AS V01;