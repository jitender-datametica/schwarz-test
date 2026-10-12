CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_lagerbew_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 lagerbew_beleg_id,
 kj,
 vorgangsart_id,
 dat_buch,
 beleg_user_name,
 COALESCE(waren_begl_schein_id, '') AS waren_begl_schein_id,
 dat_beleg,
 dat_erfasst,
 belegart_id,
 7 AS system_id,
 belegkopftext,
 COALESCE(ref_lagerbew_beleg_id, '-1') AS ref_lagerbew_beleg_id
FROM kfl_production_dbp_view.v_lagerbew_1
WHERE mandant_id = 1;