CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_pmr_angebot_werbemittel_zu (mandant_id, angebot_id,
werbemittel_art_id, werbemittel_id) AS SELECT mandant_id,
 ROUND(SAFE_CAST(angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
 werbemittelkanal_id AS werbemittel_art_id,
 werbemittel_id
FROM kfl_production_dbp_view.v_angebot_werbemittel_promotion_event_zu AS V01;