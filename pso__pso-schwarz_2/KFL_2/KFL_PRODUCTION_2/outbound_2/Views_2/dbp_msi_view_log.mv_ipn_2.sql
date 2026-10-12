CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ipn_2 AS SELECT ipn_id,
 ipn_bez,
 SUBSTR(CAST(CAST(TRUNC(ipn_id) AS STRING) || ' ' || ipn_bez AS STRING), 1, 68) AS ipn_id_bez
FROM kfl_production_dbp_view.v_ipn_2 AS V01
UNION DISTINCT
SELECT 0 AS ipn_id,
 'keine IPN_2 vorhanden' AS ipn_bez,
 '0 keine IPN_2 vorhanden' AS ipn_id_bez;