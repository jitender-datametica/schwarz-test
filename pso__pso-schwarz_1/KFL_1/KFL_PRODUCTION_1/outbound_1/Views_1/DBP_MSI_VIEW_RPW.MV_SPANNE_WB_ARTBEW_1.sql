CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_spanne_wb_artbew_1 (rcv_id, mandant_id, system_id, bewart_id,
nb_id, art_id, dat, mwst, belastungsart_id, belastungsart_vd_id, menge, ek_netto, vk_netto, vk_brutto) AS SELECT AB.wup_id
  AS rcv_id,
 AB.mandant_id,
 7 AS system_id,
 AB.bewart_id,
 AB.nb_id,
 AB.art_id,
 AB.dat,
 MP.mwst,
 SUBSTR(CAST(CASE
    WHEN AB.umsatz_netto >= 0
    THEN 251
    ELSE 252
    END AS STRING), 1, 4) AS belastungsart_id,
 4 AS belastungsart_vd_id,
 SUM(AB.menge * - 1) AS menge,
 SUM(AB.ek_netto * - 1) AS ek_netto,
 SUM(AB.umsatz_netto * - 1) AS vk_netto,
 SUM(AB.umsatz_netto * (1 + MP.mwst / 100) * - 1) AS vk_brutto
FROM kfl_production_dbp_view.v_artbew_1 AS AB
 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS MP ON AB.mwst_id = MP.mwst_id AND AB.mandant_id = MP.mandant_id AND AB
   .dat BETWEEN MP.dat_von AND MP.dat_bis
WHERE AB.mandant_id = 1
GROUP BY rcv_id,
 AB.mandant_id,
 system_id,
 AB.bewart_id,
 AB.nb_id,
 AB.art_id,
 AB.dat,
 MP.mwst,
 belastungsart_id,
 belastungsart_vd_id;