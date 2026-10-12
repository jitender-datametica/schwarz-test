CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_tqm_bewertung_1 (tqm_bewertung_id, mandant_id,
fehler_prozent_bis, fehler_prozent_von, punkte_sap_kf, punkte_sap_vk) AS SELECT SUM(1) OVER (ORDER BY fehler_prozent_bis
    IS NULL, fehler_prozent_bis ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS tqm_bewertung_id,
 mandant_id,
 CAST(CAST(fehler_prozent_bis AS BIGNUMERIC) / 100.00 AS BIGNUMERIC) AS fehler_prozent_bis,
 fehler_prozent_von,
 punkte_sap_kf,
 punkte_sap_vk
FROM kfl_production_dbp_view.v_flw_l_tqm_bewertung_1 AS V01;