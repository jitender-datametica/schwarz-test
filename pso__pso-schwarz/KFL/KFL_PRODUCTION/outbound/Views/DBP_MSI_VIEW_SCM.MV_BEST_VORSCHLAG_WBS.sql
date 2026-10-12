CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_best_vorschlag_wbs (mandant_id, wup_id, nb_id, art_id,
dat_ausfuehrung, ausliefergruppe_id, gondelkopf_fg, zweitplatzierung_fg, aktion_id, gewicht_tag1, gewicht_tag2,
gewicht_tag3, gewicht_tag4, gewicht_tag5, gewicht_tag6, gewicht_tag7, gewicht_stunde1, gewicht_stunde2, menge_min_tag1,
menge_max_tag1, wup_id_vz, mandant_id_vz, nb_id_vz, gp_id, dat_bedarf_von, dat_bedarf_bis, nachversorgung_mgl_fg,
dat_letze_nachversorgung, absatz_woche_aktion, abverkauf_projeziert_woche_aktion, abverkauf_projeziert_bestandsperiode,
abverkauf_projeziert_bedarfsperiode, menge_lgbest_bme, menge_best_offen_bme, menge_lgbest_projeziert_bme,
menge_lgbest_final_bme_min, menge_bedarf_bme, menge_bedarf_ame, menge_auffuell_ame, menge_best_vorl_bme,
menge_best_vorl_ame, menge_standardbestand_vz_ame, menge_blockbestand_vz_ame, menge_verfuegbarerbestand_vz_ame,
menge_verfuegbarerbestand_vz_ame_initial, menge_bedarf_sum_ame, fair_share_fg, rang_fair_share, mopro_mhd_fg,
clear_stock_fg, rang_clear_stock, abverkauf_durchschnitt_bme, reichweite_zielbestand, reichweite_zielbestand_clear_stock
, menge_wbs, ausnahme_pallette_fg, ausnahme_mhd_fg, ausnahme_webeabsatz_fg, menge_lgbest_initial, ausnahme_kolli_fg,
zielbestand_akt_bme, menge_wbs_final, check_vz_fg, check_wup_fg, status_verarbeitung, dat_lief_wunsch,
dispoteilsortiment_id, menge_wbs_pal, best_menge_einh_id_final, lagerort_id, order_generated_fg) AS SELECT A11.mandant_id
 ,
 V05.aktuell_wup_id AS wup_id,
 A11.nb_id,
 A11.art_id,
 A11.dat_ausfuehrung,
 A11.ausliefergruppe_id,
 A11.gondelkopf_fg,
 A11.zweitplatzierung_fg,
 A11.aktion_id,
 A11.gewicht_tag1,
 A11.gewicht_tag2,
 A11.gewicht_tag3,
 A11.gewicht_tag4,
 A11.gewicht_tag5,
 A11.gewicht_tag6,
 A11.gewicht_tag7,
 A11.gewicht_stunde1,
 A11.gewicht_stunde2,
 A11.menge_min_tag1,
 A11.menge_max_tag1,
  CASE
  WHEN A11.vz_wup_id > 9999
  THEN CAST(- 9 AS BIGNUMERIC)
  ELSE A11.vz_wup_id
  END AS wup_id_vz,
 A11.vz_mandant_id AS mandant_id_vz,
 - 111 AS nb_id_vz,
  CASE
  WHEN A11.ausliefergruppe_id = 'VEN'
  THEN A13.gp_id
  ELSE A11.vz_wup_id
  END AS gp_id,
 A11.dat_bedarf_von,
 A11.dat_bedarf_bis,
 A11.nachversorgung_mgl_fg,
 A11.dat_letze_nachversorgung,
 A11.absatz_woche_aktion,
 A11.abverkauf_projeziert_woche_aktion,
 A11.abverkauf_projeziert_bestandsperiode,
 A11.abverkauf_projeziert_bedarfsperiode,
 A11.menge_lgbest_bme,
 A11.menge_best_offen_bme,
 A11.menge_lgbest_projeziert_bme,
 A11.menge_lgbest_final_bme_min,
 A11.menge_bedarf_bme,
 A11.menge_bedarf_ame,
 A11.menge_auffuell_ame,
 A11.menge_best_vorl_bme,
 A11.menge_best_vorl_ame,
 A11.menge_standardbestand_vz_ame,
 A11.menge_blockbestand_vz_ame,
 A11.menge_verfuegbarerbestand_vz_ame,
 A11.menge_verfuegbarerbestand_vz_ame AS menge_verfuegbarerbestand_vz_ame_initial,
 A11.menge_bedarf_sum_ame,
 A11.fair_share_fg,
 A11.rang_fair_share,
 A11.mopro_mhd_fg,
 A11.clear_stock_fg,
 A11.rang_clear_stock,
 A11.abverkauf_durchschnitt_bme,
 A11.reichweite_zielbestand,
 A11.reichweite_zielbestand_clear_stock,
 A11.menge_wbs,
 COALESCE(A11.ausnahme_pallette_fg, 0) AS ausnahme_pallette_fg,
 COALESCE(A11.ausnahme_mhd_fg, 0) AS ausnahme_mhd_fg,
 COALESCE(A11.ausnahme_webeabsatz_fg, 0) AS ausnahme_webeabsatz_fg,
 A11.menge_lgbest_initial,
 COALESCE(A11.ausnahme_kolli_fg, 0) AS ausnahme_kolli_fg,
 A11.zielbestand_akt_bme,
  CASE
  WHEN A12.status_verarbeitung = 1
  THEN A12.menge_wbs_final
  ELSE A11.menge_wbs
  END AS menge_wbs_final,
 IFNULL(A12.check_vz_fg, 0) AS check_vz_fg,
 IFNULL(A12.check_wup_fg, 0) AS check_wup_fg,
 IFNULL(A12.status_verarbeitung, 0) AS status_verarbeitung,
 A11.dat_lief_wunsch,
 A11.dispoteilsortiment_id,
 A11.menge_wbs_pal,
 A11.best_menge_einh_id_final,
 COALESCE(MARC.fremd_lagerort_id, '-9') AS lagerort_id,
 A11.order_generated_fg
FROM kfl_production_dbp_view.v_best_vorschlag_wbs AS A11
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON A11.mandant_id = V05.mandant_id AND A11.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS A13 ON A11.art_id = A13.art_id AND A11.dat_ausfuehrung BETWEEN
      A13.dat_von AND A13.dat_bis AND A11.mandant_id = A13.mandant_id AND A11.nb_id = A13.nb_id AND A11.wup_id = A13.wup_id
   
 LEFT JOIN kfl_production_dbp_view.v_ts_best_vorschlag_wbs AS A12 ON A11.art_id = A12.art_id AND A11.dat_ausfuehrung =
      A12.dat_ausfuehrung AND A11.mandant_id = A12.mandant_id AND A11.nb_id = A12.nb_id AND A11.wup_id = A12.wup_id
 LEFT JOIN kfl_production_dbp_view.v_art_wup_status_per AS MARC ON A11.art_id = MARC.art_id AND A11.mandant_id = MARC.mandant_id
      AND A11.vz_wup_id = MARC.wup_id AND MARC.dat_bis = DATE '9999-12-31';