
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_1 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_lagerbestand_erp_per_1 (USERID STRING) AS SELECT V01.art_id,
 V01.gjmo_buch,
 V01.lagerort_id,
 V01.lagerort_loesch_fg,
 V01.mandant_id,
 V01.menge_lgbest_erp_frei_bme,
 V01.menge_lgbest_erp_gesp_bme,
 V01.menge_lgbest_erp_kolli,
 V01.menge_lgbest_erp_nf_charge_bme,
 V01.menge_lgbest_erp_palette,
 V01.menge_lgbest_erp_qual_bme,
 V01.menge_lgbest_erp_ret_gesp_bme,
 V01.menge_lgbest_erp_umlag_bme,
 CAST(V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_gesp_bme + V01.menge_lgbest_erp_qual_bme + V01.menge_lgbest_erp_ret_gesp_bme + V01.menge_lgbest_erp_umlag_bme AS NUMERIC)
 AS menge_lgbest_erp_bme,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.betrag_lgbest_erp * V02.umrechnungskurs * V05.ek_anzeige_fg
  ELSE V01.betrag_lgbest_erp * V05.ek_anzeige_fg
  END AS betrag_lgbest_erp,
 V01.nb_id,
 V01.pflege_status,
 V01.sperr_id,
 V01.wup_id,
 V04.dat,
 V03.wrg_id,
 V03.wrg_typ_id,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lgbest_erp * V02.umrechnungskurs
  ELSE V01.vk_netto_lgbest_erp
  END AS vk_netto_lgbest_erp
FROM kfl_production_dbp_view.v_lagerbestand_erp_per_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_kurs_1 AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V06 ON V03.wrg_typ_id = V06.wrg_typ_id
  
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V04 ON V04.dat BETWEEN V01.dat_von AND V01.dat_bis
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_1 AS V05 ON TRUE;
