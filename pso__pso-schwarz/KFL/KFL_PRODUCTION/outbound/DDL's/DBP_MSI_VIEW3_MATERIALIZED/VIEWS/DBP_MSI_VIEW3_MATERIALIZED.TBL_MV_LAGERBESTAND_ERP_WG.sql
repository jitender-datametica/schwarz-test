CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.tbl_mv_lagerbestand_erp_wg (mandant_id, wup_id, nb_id,
lagerort_id, wg_id, dat, arthiertyp_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme
, menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, menge_lgbest_erp_kolli,
menge_lgbest_erp_palette, betrag_lgbest_erp, menge_lgbest_erp_bme, wrg_id, wrg_typ_id, vk_netto_lgbest_erp) AS SELECT
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagerort_id,
 V01.wg_id,
 V01.dat,
 V01.arthiertyp_id,
 V01.menge_lgbest_erp_frei_bme,
 V01.menge_lgbest_erp_umlag_bme,
 V01.menge_lgbest_erp_qual_bme,
 V01.menge_lgbest_erp_nf_charge_bme,
 V01.menge_lgbest_erp_gesp_bme,
 V01.menge_lgbest_erp_ret_gesp_bme,
 V01.menge_lgbest_erp_kolli,
 V01.menge_lgbest_erp_palette,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.betrag_lgbest_erp * V02.umrechnungskurs
  ELSE V01.betrag_lgbest_erp
  END AS betrag_lgbest_erp,
 CAST(V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_gesp_bme + V01.menge_lgbest_erp_qual_bme + V01.menge_lgbest_erp_ret_gesp_bme + V01.menge_lgbest_erp_umlag_bme AS NUMERIC)
 AS menge_lgbest_erp_bme,
 V03.wrg_id,
 V03.wrg_typ_id,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lgbest_erp * V02.umrechnungskurs
  ELSE V01.vk_netto_lgbest_erp
  END AS vk_netto_lgbest_erp
FROM kfl_production_dbp_view.v_lagerbestand_erp_wg AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_kurs AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V03 ON V01.mandant_id = V03.mandant_id
WHERE EXTRACT(YEAR FROM V01.dat) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;