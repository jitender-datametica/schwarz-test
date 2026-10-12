CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_pmr_angebot_werbemittel_werbeflaeche_zu (angebot_id,
mandant_id, werbemittel_art_id, werbemittel_id, werbeflaeche_abschnitt_name, werbeflaeche_thema_id,
werbeflaeche_thema_bez) AS SELECT ROUND(SAFE_CAST(angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
 mandant_id,
 werbemittelkanal_id AS werbemittel_art_id,
 werbemittel_id,
 werbeflaechenabschnitt_name AS werbeflaeche_abschnitt_name,
 werbeflaechenthema_cd AS werbeflaeche_thema_id,
 werbeflaechenthema_bez AS werbeflaeche_thema_bez
FROM kfl_production_dbp_view.v_angebot_werbemittel_promotion_event_zu;