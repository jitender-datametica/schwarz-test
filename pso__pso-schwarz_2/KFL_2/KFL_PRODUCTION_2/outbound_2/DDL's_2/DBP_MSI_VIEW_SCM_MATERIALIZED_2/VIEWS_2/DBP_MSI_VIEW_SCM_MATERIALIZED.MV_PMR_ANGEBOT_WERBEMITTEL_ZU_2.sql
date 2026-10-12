CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_pmr_angebot_werbemittel_zu_2 (mandant_id,
angebot_id, werbemittel_art_id, werbemittel_id) AS SELECT mandant_id,
 angebot_id,
 werbemittel_art_id,
 werbemittel_id
FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_zu_2 AS V01;