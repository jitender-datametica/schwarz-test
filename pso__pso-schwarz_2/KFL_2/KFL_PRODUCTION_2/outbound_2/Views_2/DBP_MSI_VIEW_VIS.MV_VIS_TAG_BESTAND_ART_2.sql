CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_bestand_art_2 (mandant_id, nb_id, wup_id, bezugsweg_id,
relevant_fg, arthiertyp_id, abt_id, wg_id, art_id, gj, kjmo, kjwo, dat, menge_frei) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
  CASE
  WHEN V03.abt_id = 1 AND V01.bezugsweg_id = 1
  THEN V01.bezugsweg_id + 3
  ELSE V01.bezugsweg_id
  END AS bezugsweg_id,
 V01.relevant_fg,
 V02.arthiertyp_id,
 V03.abt_id,
 V02.wg_id,
 V02.art_id,
 V04.gj,
 V04.kjmo,
 V04.kjwo,
 V04.dat,
 V01.menge_lgbest_erp_frei_bme AS menge_frei
FROM kfl_production_dbp_view.v_marktbestand_erp_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id
      AND V02.dat_bis = DATE '9999-12-31' AND V02.arthiertyp_id = 2
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V02.mandant_id = V03.mandant_id
        AND V02.wg_id = V03.wg_id AND V02.arthiertyp_id = V03.arthiertyp_id AND V03.dat_bis = DATE '9999-12-31' AND V03
   .arthiertyp_id = 2
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V04 ON V01.dat = V04.dat AND V04.akt_tag <= 0 AND V04.akt_gj BETWEEN - 1
   AND 0
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;