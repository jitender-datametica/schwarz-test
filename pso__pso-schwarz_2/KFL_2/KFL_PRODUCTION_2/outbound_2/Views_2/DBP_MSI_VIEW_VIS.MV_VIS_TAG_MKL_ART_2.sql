CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_mkl_art_2 (mandant_id, nb_id, wup_id, dat, kj, dat_we,
dat_aenderung, problemcode_id, mkl_beleg_id, mkl_beleg_pos_id, art_id, gp_id, ref_beleg_id, verursacher_id, menge_we,
we_menge_einh_id, retoure_fg, menge_kor, kor_menge_einh_id, anzeigen_fg, kopf_fehler_fg, pos_fehler_fg) AS SELECT MKL.mandant_id
 ,
 MKL.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 MKL.dat_aenderung AS dat,
 MKL.kj,
 MKL.dat_we,
 MKL.dat_aenderung,
 MKL.problemcode_id,
 MKL.mkl_beleg_id,
 MKL.mkl_beleg_pos_id,
  CASE
  WHEN PC.kopf_fehler_fg = 1 AND MKL.anzeigen_fg = 1 AND MKL.menge_kor = MKL.menge_we
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE MKL.art_id
  END AS art_id,
 MKL.gp_id,
 MKL.ref_beleg_id,
 MKL.verursacher_id,
 MKL.menge_we,
 MKL.we_menge_einh_id,
 MKL.retoure_fg,
 MKL.menge_kor,
 MKL.kor_menge_einh_id,
 MKL.anzeigen_fg,
 PC.kopf_fehler_fg,
 PC.pos_fehler_fg
FROM kfl_production_dbp_view.v_vis_mengen_korrektur_liste_2 AS MKL
 INNER JOIN kfl_production_dbp_view.v_vis_l_problemcode_2 AS PC ON MKL.mandant_id = PC.mandant_id AND MKL.problemcode_id =
   PC.problemcode_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON MKL.mandant_id = WUP.mandant_id AND MKL.wup_id = WUP.wup_id;