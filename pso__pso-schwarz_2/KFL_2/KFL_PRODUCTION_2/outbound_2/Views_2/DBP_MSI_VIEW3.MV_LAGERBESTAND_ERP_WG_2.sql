-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_lagerbestand_erp_wg_2(USERID STRING) AS SELECT
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
 V01.betrag_lgbest_erp,
 V01.menge_lgbest_erp_bme,
 V01.wrg_id,
 V01.wrg_typ_id,
 V01.vk_netto_lgbest_erp
FROM kfl_production_dbp_msi_view3.tbl_mv_lagerbestand_erp_wg_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS V04 ON V01.wrg_typ_id = V04.wrg_typ_id;