CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_bsch_rech_det_1 (wup_id, lagerort_id, nb_id, bsch_id,
bsch_pos_id, art_id, dat, bewart_id, mandant_id, lager_bewart_id, lagerbew_beleg_id, kj, gp_id, ba_id, ba_pos_id,
menge_rech, ek_n, ek_nn, vk_n, status_1, einkaufsorganisation_id, ek_mep, ek_kb, system_id, diff_menge_rech_we,
diff_ek_n_we, diff_vk_n_we, menge_lagerbew, ek_n_lagerbew, vk_lagerbew, menge_rechnung, as_ek_n_rechnung, ek_n_rechnung
, vk_rechnung, vk_n_rechnung) AS SELECT V01.wup_id,
 V01.lagerort_id,
 V01.nb_id,
 V01.bsch_id,
 V01.bsch_pos_id,
 V01.art_id,
 V01.dat,
 V01.bewart_id,
 V01.mandant_id,
 V01.lager_bewart_id,
 TRUNC(CAST(V01.bsch_id / 10000 AS BIGNUMERIC)) AS lagerbew_beleg_id,
 MOD(V01.bsch_id, 10000) AS kj,
 V01.gp_id,
 V01.ba_id,
 V01.ba_pos_id,
 V01.menge_rech,
 V01.ek_n,
 V01.ek_nn,
 TRUNC(CAST(V01.vk_n * (100 + V03.mwst) / 100 AS BIGNUMERIC)) AS vk_n,
 V01.status_1,
 V01.einkaufsorganisation_id,
 V01.ek_mep,
 V01.ek_kb,
 7 AS system_id,
 V01.diff_menge_rech_we,
 V01.diff_ek_n_we,
 TRUNC(CAST(V01.diff_vk_n_we * (100 + V03.mwst) / 100 AS BIGNUMERIC)) AS diff_vk_n_we,
  CASE
  WHEN V01.status_1 = 1
  THEN V01.menge_rech
  WHEN V01.status_1 = 3
  THEN V01.menge_rech - V01.diff_menge_rech_we
  ELSE NULL
  END AS menge_lagerbew,
  CASE
  WHEN V01.status_1 = 1
  THEN V01.ek_n
  WHEN V01.status_1 = 3
  THEN V01.ek_n - V01.diff_ek_n_we
  ELSE NULL
  END AS ek_n_lagerbew,
  CASE
  WHEN V01.status_1 = 1
  THEN CAST(V01.vk_n * (100 + V03.mwst) / 100 AS BIGNUMERIC)
  WHEN V01.status_1 = 3
  THEN CAST(V01.vk_n * (100 + V03.mwst) / 100 AS BIGNUMERIC) - CAST(V01.diff_vk_n_we * (100 + V03.mwst) / 100 AS BIGNUMERIC)
   
  ELSE NULL
  END AS vk_lagerbew,
  CASE
  WHEN V01.status_1 = 3
  THEN V01.menge_rech
  ELSE NULL
  END AS menge_rechnung,
  CASE
  WHEN V01.status_1 = 3
  THEN V01.menge_rech * V05.ek_netto
  ELSE NULL
  END AS as_ek_n_rechnung,
  CASE
  WHEN V01.status_1 = 3
  THEN V01.ek_n
  ELSE NULL
  END AS ek_n_rechnung,
  CASE
  WHEN V01.status_1 = 3
  THEN CAST(V01.vk_n * (100 + V03.mwst) / 100 AS BIGNUMERIC)
  ELSE NULL
  END AS vk_rechnung,
  CASE
  WHEN V01.status_1 = 3
  THEN V01.vk_n
  ELSE NULL
  END AS vk_n_rechnung
FROM kfl_production_dbp_view.v_bsch_rech_det_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS V03 ON V02.mwst_id = V03.mwst_id AND V02.mandant_id = V03.mandant_id
  AND V01.dat BETWEEN V03.dat_von AND V03.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_zu_per_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
     AND V01.dat BETWEEN V04.dat_von AND V04.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per_1 AS V05 ON V01.art_id = V05.art_id AND V05.wup_id <> - 1 AND V04.gp_id
      = V05.gp_id AND V01.wup_id = V05.wup_id AND V01.dat BETWEEN V05.dat_von AND V05.dat_bis
WHERE V01.mandant_id = 1;