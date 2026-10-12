CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ts_ek_dashboard_kommentar_1 AS SELECT V01.ek_dashboard_id,
 V02.td_insert AS dwh_timestamp,
 COALESCE(V02.kommentar_txt, '') AS kommentar_txt
FROM kfl_production_dbp_msi_view2.mv_l_ek_dashboard_spr_zu_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_view2.ts_ek_dashboard_kommentar_1 AS V02 ON V01.ek_dashboard_id = V02.ek_dashboard_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY V01.ek_dashboard_id ORDER BY V02.td_insert IS NULL DESC, V02.td_insert DESC)) =
  1;