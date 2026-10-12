CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_f_markt_bestand_erp_per_1 (mandant_id, wup_id, nb_id, art_id,
wrg_id, gjmo, vk_zvkp, vknt_zvkp) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.wrg_id,
 V01.gjmo,
 ROUND(CAST((V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_umlag_bme + V01.menge_lgbest_erp_qual_bme + V01.menge_lgbest_erp_nf_charge_bme + V01.menge_lgbest_erp_gesp_bme + V01.menge_lgbest_erp_ret_gesp_bme + IFNULL(v09.menge_leergut, 0)) * V02.vk_brutto AS NUMERIC)
  , 4) AS vk_zvkp,
  CASE
  WHEN V01.nb_id = 0
  THEN ROUND(CAST((V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_umlag_bme + V01.menge_lgbest_erp_qual_bme + V01.menge_lgbest_erp_nf_charge_bme + V01.menge_lgbest_erp_gesp_bme + V01.menge_lgbest_erp_ret_gesp_bme + IFNULL(v09.menge_leergut, 0)) * (V02.vk_brutto - V02.vk_brutto * V06.mwst / 100
        ) AS NUMERIC), 4)
  WHEN V01.nb_id = - 111
  THEN ROUND(CAST((V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_umlag_bme + V01.menge_lgbest_erp_qual_bme + V01.menge_lgbest_erp_nf_charge_bme + V01.menge_lgbest_erp_gesp_bme + V01.menge_lgbest_erp_ret_gesp_bme + IFNULL(v09.menge_leergut, 0)) * V07.betrag_vk_netto_vz AS NUMERIC)
   , 4)
  ELSE 0
  END AS vknt_zvkp
FROM kfl_production_dbp_view.v_bestand_erp_monat_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V12 ON V01.gjmo = V12.gjmo
 LEFT JOIN kfl_production_dbp_view.v_art_wup_vk_per_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id
       AND V01.wup_id = V02.wup_id AND V01.nb_id = V02.nb_id AND V12.max_dat BETWEEN V02.dat_von AND V02.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_per_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.art_id = V05.art_id AND
   V12.max_dat BETWEEN V05.dat_von AND V05.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.mwst_id = V06.mwst_id
  AND V06.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_lagerbew_det_1 AS V07 ON V01.mandant_id = V07.mandant_id AND V01.wup_id = V07.wup_id
     AND V01.nb_id = V07.nb_id AND V01.art_id = V07.art_id AND V12.max_dat = V07.dat_buch AND V07.nb_id = -111
 LEFT JOIN (SELECT V10.mandant_id,
   V10.wup_id,
   V10.art_id,
   V10.gjmo,
   V11.wg_id,
   SUM(V10.menge_bestand_geb_leergut) AS menge_leergut
  FROM kfl_production_dbp_data.art_wup_status_periode_1 AS V10
   INNER JOIN kfl_production_dbp_data.art_wg_zu_per_1 AS V11 ON V10.mandant_id = V11.mandant_id AND V10.art_id = V11.art_id
        AND V11.arthiertyp_id = 2 AND V11.dat_bis = DATE '9999-12-31'
  WHERE V10.mandant_id = 1
   AND V10.menge_bestand_geb_leergut <> 0
  GROUP BY V10.art_id,
   V10.mandant_id,
   V10.wup_id,
   V10.gjmo,
   V11.wg_id) AS v09 ON V01.mandant_id = v09.mandant_id AND V01.art_id = v09.art_id AND V01.wup_id = v09.wup_id AND V01
   .gjmo = v09.gjmo;