-- Artikel ohne IPN
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ipn (ipn_id, ipn_bez,
ipn_id_bez) AS SELECT ipn_id,
 ipn_bez,
   CAST(TRUNC(ipn_id) AS STRING) || ' ' || ipn_bez AS ipn_id_bez
FROM kfl_production_dbp_view.v_ipn AS V01
UNION DISTINCT
SELECT 0 AS ipn_id,
 'keine IPN vorhanden' AS ipn_bez,
 '0 keine IPN vorhanden' AS ipn_id_bez;