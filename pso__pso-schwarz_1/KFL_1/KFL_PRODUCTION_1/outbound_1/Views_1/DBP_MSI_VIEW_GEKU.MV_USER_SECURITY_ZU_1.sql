CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_user_security_zu_1 (user_id, mandant_id, sec_kz) AS SELECT
 LOWER(V01.user_id) AS user_id,
 V02.mandant_id,
 V01.sec_kz
FROM kfl_production_dbp_msi_v_view.v_ts_kmr_user_sec_kz_zu_1 AS V01
 INNER JOIN kfl_production_dbp_security.user_mandant_msiprodukt_zu_1 AS V02 ON V01.user_id = V02.user_id AND V02.msi_produkt_bez
    = 'KMR';