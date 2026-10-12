CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_lagerbestand_erp_per_1 (art_id, gjmo_buch, lagerort_id,
lagerort_loesch_fg, mandant_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_kolli,
menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_palette, menge_lgbest_erp_qual_bme, menge_lgbest_erp_ret_gesp_bme,
menge_lgbest_erp_umlag_bme, betrag_lgbest_erp, nb_id, pflege_status, sperr_id, wup_id, dat, wrg_id, vk_netto_lgbest_erp
, menge_blockbestand_act, menge_blockbestand_iwt, lgort_is_lgfsb_fg) AS SELECT V01.art_id,
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
 V01.betrag_lgbest_erp,
 V01.nb_id,
 V01.pflege_status,
 V01.sperr_id,
 V01.wup_id,
 V02.dat,
 V01.wrg_id,
 V01.vk_netto_lgbest_erp,
 V03.menge_blockbestand AS menge_blockbestand_act,
 V04.menge_blockbestand AS menge_blockbestand_iwt,
  CASE
  WHEN V011.fremd_lagerort_id = V01.lagerort_id
  THEN 1
  ELSE 0
  END AS lgort_is_lgfsb_fg
FROM kfl_production_dbp_view.v_lagerbestand_erp_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_1 AS V011 ON V01.mandant_id = V011.mandant_id AND V01.wup_id =
      V011.wup_id AND V01.nb_id = V011.nb_id AND V01.art_id = V011.art_id AND V02.dat BETWEEN V011.dat_von AND V011.dat_bis
   
 LEFT JOIN kfl_production_dbp_view.v_blockbestand_per_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id
        AND V01.nb_id = V03.nb_id AND V01.art_id = V03.art_id AND V02.dat BETWEEN V03.dat_von AND V03.dat_bis AND V03.prozess_id
    = 1
 LEFT JOIN kfl_production_dbp_view.v_blockbestand_per_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.wup_id = V04.wup_id
        AND V01.nb_id = V04.nb_id AND V01.art_id = V04.art_id AND V02.dat BETWEEN V04.dat_von AND V04.dat_bis AND V04.prozess_id
    = 2;