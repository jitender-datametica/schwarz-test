CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.tbl_mv_lagerbestand_erp_per (art_id, gjmo_buch, lagerort_id,
lagerort_loesch_fg, mandant_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_kolli,
menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_palette, menge_lgbest_erp_qual_bme, menge_lgbest_erp_ret_gesp_bme,
menge_lgbest_erp_umlag_bme, menge_lgbest_erp_bme, nb_id, pflege_status, sperr_id, wup_id, dat, wrg_id, wrg_typ_id,
vk_netto_lgbest_erp, umrechnungskurs, betrag_lgbest_erp) AS SELECT V01.art_id,
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
 V01.nb_id,
 V01.pflege_status,
 V01.sperr_id,
 V01.wup_id,
 V04.dat,
 V03.wrg_id,
 V03.wrg_typ_id,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lgbest_erp * v02.umrechnungskurs
  ELSE V01.vk_netto_lgbest_erp
  END AS vk_netto_lgbest_erp,
 v02.umrechnungskurs,
 V01.betrag_lgbest_erp
FROM kfl_production_dbp_view.v_lagerbestand_erp_per AS V01
 INNER JOIN (SELECT umrechnungskurs,
   von_wrg_id
  FROM kfl_production_dbp_view.v_kurs
  WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
   AND kurstyp_id = 3) AS v02 ON V01.wrg_id = v02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_tag AS V04 ON V04.dat BETWEEN V01.dat_von AND V01.dat_bis;