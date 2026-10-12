CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_gp_wup_nm_zu_per_2 (mandant_id, art_id, gp_id, wup_id, nb_id
, wrg_id, gjmo, ek_netto_bnk, ek_mep, einstandspreis, logistikkostenzuschlag) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.gp_id,
 V01.wup_id,
 V01.nb_id,
 V03.wrg_id,
 V03.gjmo,
 ROUND(CAST((V03.menge_lgbest_erp_frei_bme + V03.menge_lgbest_erp_umlag_bme + V03.menge_lgbest_erp_qual_bme + V03.menge_lgbest_erp_nf_charge_bme + V03.menge_lgbest_erp_gesp_bme + V03.menge_lgbest_erp_ret_gesp_bme + IFNULL(t1.menge_leergut, 0)) * V01.ek_netto_bnk AS NUMERIC)
  , 4) AS ek_netto_bnk,
 ROUND(CAST((V03.menge_lgbest_erp_frei_bme + V03.menge_lgbest_erp_umlag_bme + V03.menge_lgbest_erp_qual_bme + V03.menge_lgbest_erp_nf_charge_bme + V03.menge_lgbest_erp_gesp_bme + V03.menge_lgbest_erp_ret_gesp_bme + IFNULL(t1.menge_leergut, 0)) * V01.ek_mep AS NUMERIC)
  , 4) AS ek_mep,
 ROUND(CAST((V03.menge_lgbest_erp_frei_bme + V03.menge_lgbest_erp_umlag_bme + V03.menge_lgbest_erp_qual_bme + V03.menge_lgbest_erp_nf_charge_bme + V03.menge_lgbest_erp_gesp_bme + V03.menge_lgbest_erp_ret_gesp_bme + IFNULL(t1.menge_leergut, 0)) * V01.einstandspreis AS NUMERIC)
  , 4) AS einstandspreis,
 ROUND(CAST((V03.menge_lgbest_erp_frei_bme + V03.menge_lgbest_erp_umlag_bme + V03.menge_lgbest_erp_qual_bme + V03.menge_lgbest_erp_nf_charge_bme + V03.menge_lgbest_erp_gesp_bme + V03.menge_lgbest_erp_ret_gesp_bme + IFNULL(t1.menge_leergut, 0)) * V01.logistikkostenzuschlag AS NUMERIC)
  , 4) AS logistikkostenzuschlag
FROM kfl_production_dbp_msi_view_wwc.tbl_mv_art_gp_wup_nm_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_bestand_erp_monat_2 AS V03 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS V12 ON V03.gjmo = V12.gjmo AND V03.mandant_id = V01.mandant_id AND V03.art_id
       = V01.art_id AND V03.wup_id = V01.wup_id AND V12.max_dat BETWEEN V01.dat_von AND V01.dat_bis AND V12.akt_gj
   BETWEEN - 2 AND 0
 LEFT JOIN (SELECT V10.mandant_id,
   V10.wup_id,
   V10.art_id,
   V10.gjmo,
   V11.wg_id,
   SUM(V10.menge_bestand_geb_leergut) AS menge_leergut
  FROM kfl_production_dbp_data.art_wup_status_periode_2 AS V10
   INNER JOIN kfl_production_dbp_data.art_wg_zu_per_2 AS V11 ON V10.mandant_id = V11.mandant_id AND V10.art_id = V11.art_id
        AND V11.arthiertyp_id = 2 AND V11.dat_bis = DATE '9999-12-31'
  WHERE V10.mandant_id = 1
   AND V10.menge_bestand_geb_leergut <> 0
  GROUP BY V10.art_id,
   V10.mandant_id,
   V10.wup_id,
   V10.gjmo,
   V11.wg_id) AS t1_2 ON V03.mandant_id = t1.mandant_id AND V03.art_id = t1.art_id AND V03.wup_id = t1.wup_id AND V03.gjmo
    = t1.gjmo;