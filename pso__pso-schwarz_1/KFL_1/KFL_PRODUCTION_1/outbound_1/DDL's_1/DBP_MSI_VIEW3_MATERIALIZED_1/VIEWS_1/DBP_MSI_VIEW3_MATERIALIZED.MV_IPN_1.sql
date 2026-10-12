-- Artikel_1 ohne IPN_1
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ipn_1 (ipn_id, ipn_bez,
ipn_id_bez) AS SELECT ipn_id,
 ipn_bez,
   CAST(TRUNC(ipn_id) AS STRING) || ' ' || ipn_bez AS ipn_id_bez
FROM kfl_production_dbp_view.v_ipn_1 AS V01
UNION DISTINCT
SELECT 0 AS ipn_id,
 'keine IPN_1 vorhanden' AS ipn_bez,
 '0 keine IPN_1 vorhanden' AS ipn_id_bez;