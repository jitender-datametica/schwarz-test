CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_besch_best_det (mandant_id, best_beleg_id, best_beleg_pos_id
, art_id, wup_id, nb_id, lagerort_id, loesch_fg, menge_best_bme, selbstabhol_fg, best_preis_menge_einh_id,
menge_best_kolli, menge_best_palette, endlief_fg, dat_aenderung, kunde_id, dat_best_beleg, best_menge_einh_id, ean_id,
betrag_kond_zw_sum2, pos_kostenlos_fg, betrag_pos_netto, betrag_pos_netto_best_wrg, wrg_id, betrag_best,
menge_block_bestand, gp_teilsortiment_id, dat_lief_wunsch, dat_naechst_verkaufstag) AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagerort_id,
 V01.loesch_fg,
 V01.menge_best_bme,
 V01.selbstabhol_fg,
 V01.best_preis_menge_einh_id,
 V01.menge_best_kolli,
 V01.menge_best_palette,
 V01.endlief_fg,
 V01.dat_aenderung,
 V01.kunde_id,
 V01.dat_best_beleg,
 V01.best_menge_einh_id,
 V01.ean_id,
 V01.betrag_kond_zw_sum2,
 V01.pos_kostenlos_fg,
 V01.betrag_pos_netto,
 V01.betrag_pos_netto_best_wrg,
 V01.wrg_id,
 V01.betrag_best,
 V01.menge_block_bestand,
 V01.gp_teilsortiment_id,
 v02.dat_lief_wunsch,
 V03.dat_naechst_verkaufstag
FROM kfl_production_dbp_view.v_besch_best_det AS V01
 INNER JOIN (SELECT best_beleg_id,
   mandant_id,
   best_beleg_pos_id,
   dat_lief_wunsch,
   einteil_id,
   flw_fg
  FROM kfl_production_dbp_view.v_lief_einteilung AS V11
  WHERE flw_fg = 1
   AND einteil_id = 1) AS v02 ON V01.best_beleg_id = v02.best_beleg_id AND V01.mandant_id = v02.mandant_id AND V01.best_beleg_pos_id
     = v02.best_beleg_pos_id AND V01.flw_fg = v02.flw_fg
 LEFT JOIN kfl_production_dbp_view.v_art_wup_tag_denorm AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
      AND V01.wup_id = V03.wup_id AND v02.dat_lief_wunsch = V03.dat
WHERE V01.mandant_id = 1
 AND V01.flw_fg = 1
 AND V01.loesch_fg = 0;