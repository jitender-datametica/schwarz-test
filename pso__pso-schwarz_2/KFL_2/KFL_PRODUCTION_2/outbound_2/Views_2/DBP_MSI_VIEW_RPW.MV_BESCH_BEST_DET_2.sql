CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_best_det_2 (mandant_id, best_beleg_id, best_beleg_pos_id,
art_id, empfaenger_wup_id, nb_id, lagerort_id, loesch_fg, menge_best, selbstabhol_fg, best_preis_menge_einh_id,
menge_kolli, menge_palette, endlief_fg, dat_aenderung, kunde_id, dat_best_beleg, best_basismenge_einh_id, ean_id,
betrag_kond_zw_sum2, pos_kostenlos_fg, betrag_pos_netto, betrag_pos_netto_best_wrg, vk_brutto, system_id, kj,
menge_block_bestand, gp_teilsortiment_id) AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.art_id,
 V01.wup_id AS empfaenger_wup_id,
 V01.nb_id,
 V01.lagerort_id,
 V01.loesch_fg,
 V01.menge_best_bme AS menge_best,
 V01.selbstabhol_fg,
 V01.best_preis_menge_einh_id,
 V01.menge_best_kolli AS menge_kolli,
 V01.menge_best_palette AS menge_palette,
 V01.endlief_fg,
 V01.dat_aenderung,
 V01.kunde_id,
 V01.dat_best_beleg,
 V01.best_menge_einh_id AS best_basismenge_einh_id,
 V01.ean_id,
 V01.betrag_kond_zw_sum2,
 V01.pos_kostenlos_fg,
 V01.betrag_pos_netto,
 V01.betrag_pos_netto_best_wrg,
  V03.vk_brutto * V01.menge_best_bme AS vk_brutto,
 7 AS system_id,
 EXTRACT(YEAR FROM V01.dat_best_beleg) AS kj,
 V01.menge_block_bestand,
 V01.gp_teilsortiment_id
FROM kfl_production_dbp_view.v_besch_best_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_best_2 AS V02 ON V01.best_beleg_id = V02.best_beleg_id AND V01.mandant_id =
    V02.mandant_id AND V01.dat_best_beleg = V02.dat_best_beleg
 LEFT JOIN kfl_production_dbp_view.v_art_wup_zu_per_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
       AND V01.wup_id = V03.wup_id AND V01.nb_id = V03.nb_id AND V01.dat_best_beleg BETWEEN V03.dat_von AND V03.dat_bis
WHERE V01.mandant_id = 1
 AND V02.einkaufsorganisation_id <> 5000;